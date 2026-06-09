<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Candidate;
use App\Models\Employer;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

//use PHPOpenSourceSaver\JWTAuth\Facades\JWTAuth;

class AuthController extends Controller
{
    public function __construct()
    {
        $this->middleware('jwt', ['except' => ['login', 'register']]);
    }

    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|string|email',
            'password' => 'required|string',
        ]);

        $credentials = $request->only('email', 'password');
        $token = Auth::attempt($credentials);

        if (! $token) {
            return response()->json([
                'message' => 'Unauthorized',
            ], 401);
        }

        $user = Auth::user();

        if ((int) $user->role !== (int) $request->role || ! $user->is_active) {
            Auth::logout();

            return response()->json([
                'message' => 'Unauthorized',
            ], 401);
        }

        if ($request->role == 1) {
            $name = User::join('candidates', 'users.id', '=', 'user_id')
                ->where('users.id', $user->id)
                ->select('firstname', 'lastname')
                ->first();
            // dd($name->firstname);
            $user['name'] = $name;
        }

        return response()->json([
            'user' => $user,
            'authorization' => [
                'token' => $token,
                'type' => 'bearer',
            ],
        ]);
    }

    public function register(Request $request)
    {
        $request->validate([
            // 'firstname' => 'required|string|max:100',
            // 'lastname' => 'required|string|max:100',
            'email' => 'email|max:255|unique:users',
            // 'password' => 'required|string|min:6',
        ]);

        User::create([
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'role' => 1,
            'is_active' => 1,
        ]);

        $user = User::orderBy('id', 'desc')->first();
        Candidate::create([
            'id' => $user->id,
            'user_id' => $user->id,
            'firstname' => $request->firstname,
            'lastname' => $request->lastname,
            'email' => $request->email,
        ]);

        // $credentials = $request->only('email', 'password');
        // $token = Auth::attempt($credentials);
        // if ($user->role == 1) {
        //     $user['name'] = [
        //         'firstname' => $request->firstname,
        //         'lastname' => $request->lastname
        //     ];
        // }

        return response()->json([
            'message' => 'User created successfully',
            'user' => $user,
            // 'authorization' => [
            //     'token' => $token,
            //     'type' => 'bearer',
            // ]
        ], 201);
    }

    public function registerEmployer(Request $request)
    {
        $request->validate([
            'email' => 'required|email|max:255|unique:users',
            'password' => 'required|string|min:6',
            'name' => 'required|string|max:150',
            'address' => 'required|string|max:255',
            'contact_name' => 'nullable|string|max:60',
            'phone' => 'nullable|string|max:15',
            'website' => 'nullable|string|max:255',
            'description' => 'nullable|string',
        ]);

        $user = DB::transaction(function () use ($request) {
            $user = User::create([
                'email' => $request->email,
                'password' => Hash::make($request->password),
                'role' => 2,
                'is_active' => 1,
            ]);

            Employer::create([
                'id' => $user->id,
                'user_id' => $user->id,
                'name' => $request->name,
                'address' => $request->address,
                'contact_name' => $request->contact_name,
                'phone' => $request->phone,
                'website' => $request->website,
                'description' => $request->description,
                'logo' => '',
                'is_hot' => 0,
                'is_active' => 1,
            ]);

            return $user;
        });

        return response()->json([
            'message' => 'Employer created successfully',
            'user' => $user,
        ], 201);
    }

    public function me()
    {
        $user = Auth::user();
        if ($user->role == 2) {
            $user = User::with('employer')->find($user->id);
        }
        if ($user->role == 1) {
            $name = User::join('candidates', 'users.id', '=', 'user_id')
                ->where('users.id', $user->id)
                ->select('firstname', 'lastname')
                ->first();
            $user['name'] = $name;
        }
        if (! $user) {
            return response()->json([
                'message' => 'Unauthorized',
            ], 401);
        }

        return response()->json($user);
    }

    public function logout()
    {
        Auth::logout();

        return response()->json([
            'message' => 'Successfully logged out',
        ]);
    }

    public function refresh()
    {
        return response()->json([
            'user' => Auth::user(),
            'authorization' => [
                'token' => Auth::refresh(),
                'type' => 'bearer',
            ],
        ]);
    }
}

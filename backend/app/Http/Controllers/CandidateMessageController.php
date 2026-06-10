<?php

namespace App\Http\Controllers;

use App\Models\CandidateMessage;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CandidateMessageController extends Controller
{
    public function getByCandidateID($id)
    {
        $this->authorizeCandidate($id);
        $msgs = CandidateMessage::where('candidate_id', '=', Auth::id())
            ->orderByDesc('created_at')
            ->get();

        return response()->json($msgs);
    }
    public function updateReadMsg($id)
    {
        $res = CandidateMessage::where('id', '=', $id)
            ->where('candidate_id', Auth::id())
            ->update(['isRead' => 1]);
        if ($res) {
            $msg = "Updated successfully!";
        } else {
            $msg = "Updated failed!";
        }

        return response()->json($msg);
    }

    public function updateUnreadMsg($id)
    {
        $res = CandidateMessage::where('id', '=', $id)
            ->where('candidate_id', Auth::id())
            ->update(['isRead' => 0]);

        return response()->json($res ? 'Updated successfully!' : 'Updated failed!');
    }

    public function unreadCount()
    {
        $count = CandidateMessage::where('candidate_id', Auth::id())
            ->where('isRead', 0)
            ->count();

        return response()->json(['count' => $count]);
    }

    public function markAllAsRead()
    {
        CandidateMessage::where('candidate_id', Auth::id())
            ->where('isRead', 0)
            ->update(['isRead' => 1]);

        return response()->json('Updated successfully!');
    }

    private function authorizeCandidate($candidateId): void
    {
        abort_unless((int) Auth::id() === (int) $candidateId && (int) Auth::user()?->role === 1, 403);
    }
}

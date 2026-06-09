import { useState } from "react";
import { useForm } from "react-hook-form";
import { useNavigate } from "react-router-dom";
import authApi from "../../api/auth";

function AdminLogin() {
  const nav = useNavigate();
  const { register, handleSubmit } = useForm();
  const [msg, setMsg] = useState("");
  const [isLoading, setIsLoading] = useState(false);

  const onSubmit = async (data) => {
    setIsLoading(true);
    setMsg("");
    try {
      const res = await authApi.login({ ...data, role: 0 });
      localStorage.setItem("admin_jwt", res.authorization.token);
      nav("/admin");
    } catch (e) {
      setMsg("Email hoặc mật khẩu admin không chính xác!");
    }
    setIsLoading(false);
  };

  return (
    <div className="mx-auto" style={{ marginTop: "150px", width: "30%" }}>
      <form className="border px-4 py-3 rounded shadow" onSubmit={handleSubmit(onSubmit)}>
        <h4 className="mb-3 text-center text-main">Admin đăng nhập</h4>
        <label className="mb-1">Email</label>
        <input className="form-control" type="text" {...register("email", { required: true })} />
        <label className="mt-2 mb-1">Mật khẩu</label>
        <input className="form-control" type="password" {...register("password", { required: true })} />
        {msg && <div className="text-danger text-center mt-2">{msg}</div>}
        <button className="btn btn-primary w-100 mt-3" type="submit">
          Đăng nhập
          {isLoading && <span className="spinner-border spinner-border-sm ms-1" />}
        </button>
      </form>
    </div>
  );
}

export default AdminLogin;

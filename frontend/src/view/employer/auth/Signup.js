import { useState } from "react";
import { useForm } from "react-hook-form";
import { Link, useNavigate } from "react-router-dom";
import { toast } from "react-toastify";
import authApi from "../../../api/auth";

function EmployerSignup() {
  const {
    register,
    formState: { errors },
    handleSubmit,
    watch,
  } = useForm();
  const nav = useNavigate();
  const [isLoading, setIsLoading] = useState(false);
  const requiredMark = <span className="text-danger"> *</span>;
  const requiredError = <div className="text-danger text-start small">Vui lòng nhập thông tin!</div>;

  const onSubmit = async (data) => {
    if (data.password !== data.re_password) {
      toast.error("Mật khẩu nhập lại không khớp");
      return;
    }

    setIsLoading(true);
    try {
      const payload = { ...data };
      delete payload.re_password;
      await authApi.registerEmployer(payload);
      toast.success("Đăng ký tài khoản nhà tuyển dụng thành công");
      nav("/employer/login");
    } catch (e) {
      toast.error(e?.response?.data?.message || "Email đã tồn tại hoặc thông tin chưa hợp lệ");
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="mx-auto" style={{ marginTop: "70px", width: "42%" }}>
      <form className="border px-4 py-3 rounded shadow bg-white" onSubmit={handleSubmit(onSubmit)}>
        <h4 className="mb-3 text-center text-main">Nhà tuyển dụng đăng ký</h4>
        <div className="row g-2">
          <div className="col-md-6">
            <label className="mb-1">Email{requiredMark}</label>
            <input className="form-control" type="email" placeholder="Email đăng nhập" {...register("email", { required: true })} />
            {errors.email && requiredError}
          </div>
          <div className="col-md-6">
            <label className="mb-1">Tên công ty{requiredMark}</label>
            <input className="form-control" placeholder="Tên công ty" {...register("name", { required: true })} />
            {errors.name && requiredError}
          </div>
          <div className="col-md-6">
            <label className="mb-1">Mật khẩu{requiredMark}</label>
            <input className="form-control" type="password" placeholder="Tối thiểu 6 ký tự" {...register("password", { required: true, minLength: 6 })} />
            {errors.password && <div className="text-danger text-start small">Mật khẩu tối thiểu 6 ký tự!</div>}
          </div>
          <div className="col-md-6">
            <label className="mb-1">Nhập lại mật khẩu{requiredMark}</label>
            <input className="form-control" type="password" {...register("re_password", { required: true })} />
            {errors.re_password && requiredError}
            {watch("re_password") && watch("password") !== watch("re_password") && (
              <div className="text-danger text-start small">Mật khẩu nhập lại không khớp!</div>
            )}
          </div>
          <div className="col-12">
            <label className="mb-1">Địa chỉ công ty{requiredMark}</label>
            <input className="form-control" placeholder="Địa chỉ" {...register("address", { required: true })} />
            {errors.address && requiredError}
          </div>
          <div className="col-md-6">
            <label className="mb-1">Người liên hệ</label>
            <input className="form-control" placeholder="Tên người liên hệ" {...register("contact_name")} />
          </div>
          <div className="col-md-6">
            <label className="mb-1">Số điện thoại</label>
            <input className="form-control" placeholder="Số điện thoại" {...register("phone")} />
          </div>
          <div className="col-12">
            <label className="mb-1">Website</label>
            <input className="form-control" placeholder="https://..." {...register("website")} />
          </div>
          <div className="col-12">
            <label className="mb-1">Mô tả công ty</label>
            <textarea className="form-control" rows={4} placeholder="Giới thiệu ngắn về công ty" {...register("description")} />
          </div>
        </div>
        <button type="submit" className="btn btn-primary w-100 mt-3" disabled={isLoading}>
          Đăng ký
          {isLoading && <span className="spinner-border spinner-border-sm ms-1" />}
        </button>
        <div className="mt-3 text-center">
          Đã có tài khoản? <Link to="/employer/login" className="text-decoration-none">Đăng nhập</Link>
        </div>
      </form>
    </div>
  );
}

export default EmployerSignup;

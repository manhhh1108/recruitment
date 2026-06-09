import { useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { BsFillPersonFill } from "react-icons/bs";

function AdminLayout({ children }) {
  const nav = useNavigate();

  useEffect(() => {
    if (!localStorage.getItem("admin_jwt")) nav("/admin/login");
  }, [nav]);

  const logout = () => {
    localStorage.removeItem("admin_jwt");
    nav("/admin/login");
  };

  return (
    <>
      <nav className="navbar border-bottom shadow-sm fixed-top bg-white">
        <div className="navbar-brand ms-3 text-secondary">Recruitment Admin</div>
        <div className="dropdown pointer">
          <div className="d-flex align-items-center me-5 dropdown-toggle" data-bs-toggle="dropdown">
            <BsFillPersonFill className="fs-4 me-1" />
            Admin
          </div>
          <ul className="dropdown-menu">
            <li className="dropdown-item" onClick={logout}>
              Đăng xuất
            </li>
          </ul>
        </div>
      </nav>
      <div className="d-flex" style={{ marginTop: "57px" }}>
        <div className="ts-smd fw-500 text-secondary bg-white border-end" style={{ width: "230px", minHeight: "calc(100vh - 57px)" }}>
          <div className="text-center text-main border-bottom py-3 px-2 fw-500">
            Quản trị hệ thống
          </div>
          <div className="ps-4 py-2 bg-mlight text-main">Dashboard</div>
        </div>
        <div className="flex-fill">{children}</div>
      </div>
    </>
  );
}

export default AdminLayout;

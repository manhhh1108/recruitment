import { AiTwotoneAppstore } from "react-icons/ai";
import {
  BsFillBriefcaseFill,
  BsFillPeopleFill,
  BsFillPersonFill,
  // BsMessenger,
} from "react-icons/bs";
import { useLocation, useNavigate } from "react-router-dom";
import "./layout_style.css";
import { useContext, useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";
import authApi from "../../../api/auth";
import { employerAuthActions } from "../../../redux/slices/employerAuthSlice";
import { AppContext } from "../../../App";
import clsx from "clsx";

function Layout(props) {
  const nav = useNavigate();
  const location = useLocation();
  const { currentPage, setCurrentPage } = useContext(AppContext);

  const company = useSelector((state) => state.employerAuth.current.employer);
  const dispatch = useDispatch();

  const handleLogout = async () => {
    try {
      await authApi.logout(2);
    } catch (e) {
      // Token may already be expired; client state still needs to be cleared.
    }
    dispatch(employerAuthActions.logout());
    localStorage.removeItem("employer_jwt");
    nav("/employer/login");
  };
  const getMe = async () => {
    try {
      const res = await authApi.getMe(2);
      dispatch(employerAuthActions.setUser(res));
    } catch (e) {
      dispatch(employerAuthActions.logout());
      localStorage.removeItem("employer_jwt");
      nav("/employer/login");
    }
  };
  const handleChangePage = (url) => {
    nav(url);
    setCurrentPage(url);
  };

  useEffect(() => {
    setCurrentPage(location.pathname);
  }, [location.pathname, setCurrentPage]);

  useEffect(() => {
    if (!localStorage.getItem("employer_jwt")) {
      nav("/employer/login");
    } else {
      getMe();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <>
      <nav className="navbar border-bottom shadow-sm fixed-top">
        <div className="navbar-brand ms-3 text-secondary">Recruitment</div>
        <div className="dropdown" style={{ cursor: "pointer" }}>
          <div
            className="d-flex align-items-center me-5 dropdown-toggle"
            data-bs-toggle="dropdown"
          >
            <BsFillPersonFill style={{ fontSize: "26px" }} />
            Company Account
          </div>
          <ul className="dropdown-menu">
            <li className="dropdown-item" onClick={handleLogout}>
              Đăng xuất
            </li>
          </ul>
        </div>
      </nav>
      <div
        className="d-flex flex-column flex-lg-row"
        style={{ marginTop: "57px" }}
      >
        <div className="ts-smd fw-500 text-secondary menu-part d-flex flex-row flex-lg-column bg-white border-bottom border-lg-end">
          <div className="text-center text-main border-lg-bottom py-3 px-2 fw-500">
            {company && company.name}
          </div>
          <div
            className={clsx(
              "d-flex align-items-center ps-lg-5 py-lg-2 px-2 pointer hover-bgt-light",
              currentPage === "/employer" && "bg-mlight text-main"
            )}
            onClick={() => handleChangePage("/employer")}
          >
            <AiTwotoneAppstore className="fs-5 me-1" />
            Dashboard
          </div>
          <div
            className={clsx(
              "d-flex align-items-center ps-lg-5 py-lg-2 px-2 pointer hover-bgt-light",
              currentPage === "/employer/jobs" && "bg-mlight text-main"
            )}
            onClick={() => handleChangePage("/employer/jobs")}
          >
            <BsFillBriefcaseFill className="ts-lg me-1" />
            Việc làm
          </div>
          <div
            className={clsx(
              "d-flex align-items-center ps-lg-5 py-lg-2 px-2 pointer hover-bgt-light",
              currentPage === "/employer/candidates" && "bg-mlight text-main"
            )}
            onClick={() => handleChangePage("/employer/candidates")}
          >
            <BsFillPeopleFill className="fs-5 me-1" /> Ứng viên
          </div>
      
        </div>
        <div className="content-part page-body">{props.children}</div>
      </div>
    </>
  );
}
export default Layout;

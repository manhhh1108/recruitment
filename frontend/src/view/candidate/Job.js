import "./job.css";
import { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import { AiFillHeart, AiOutlineHeart, AiOutlinePlus } from "react-icons/ai";
import {
  BsCalendar2Check,
  BsCalendarEvent,
  BsFillBriefcaseFill,
  BsFillGeoAltFill,
  BsFillPeopleFill,
  BsFillPersonFill,
  BsPersonWorkspace,
  BsUpload,
} from "react-icons/bs";
import { FaIndustry } from "react-icons/fa";
import { useSelector } from "react-redux";
import jobApi from "../../api/job";
import candidateApi from "../../api/candidate";
import resumeApi from "../../api/resume";
import { MdOutlineAttachMoney } from "react-icons/md";
import { IoMdPeople } from "react-icons/io";
import dayjs from "dayjs";
import Button from "react-bootstrap/Button";
import {
  bannerFallback,
  logoFallback,
  useBannerFallback,
  useLogoFallback,
} from "../../common/imageFallback";

function Job() {
  const { id } = useParams();
  const nav = useNavigate();
  const [job, setJob] = useState({
    employer: {},
    jtype: {},
    jlevel: {},
    industries: {},
  });
  const user = useSelector((state) => state.candAuth.current);
  const isAuth = useSelector((state) => state.candAuth.isAuth);
  const [isApplied, setIsApplied] = useState(false);
  const [applyStatus, setApplyStatus] = useState("");
  const [isUpload, setIsUpload] = useState(false);
  const [isSaved, setIsSaved] = useState(false);
  const [file, setFile] = useState();
  const [resumes, setResumes] = useState([]);
  const [selectedResumeId, setSelectedResumeId] = useState("");
  const [industries, setIndustries] = useState([]);
  const isExpired = job.is_expired || dayjs(job.expire_at).endOf("day").isBefore(dayjs());

  const statusText = {
    pending: "Đã nộp hồ sơ",
    viewed: "Nhà tuyển dụng đã xem",
    suitable: "Phù hợp",
    rejected: "Từ chối",
    interview: "Mời phỏng vấn",
    cancelled: "Đã hủy ứng tuyển",
    WAITING: "Đã nộp hồ sơ",
    BROWSING_RESUME: "Nhà tuyển dụng đã xem",
    RESUME_FAILED: "Từ chối hồ sơ",
    BROWSING_INTERVIEW: "Mời phỏng vấn",
    INTERVIEW_FAILED: "Từ chối sau phỏng vấn",
    PASSED: "Phù hợp",
  };

  const getJobInf = async () => {
    const res = await jobApi.getById(id);
    setJob(res);
    setIndustries(res.industries);
  };

  const checkApplying = async () => {
    const res = await jobApi.checkApplying(id);
    setIsApplied(res.value);
    setApplyStatus(res.status || "");
    console.log("is applying?", res.value);
  };

  const handleApply = async () => {
    if (isExpired) {
      alert("Tin tuyển dụng đã hết hạn nộp hồ sơ!");
      return;
    }
    if (!isUpload && !selectedResumeId) {
      alert("Vui lòng chọn CV trong hệ thống hoặc tải CV lên!");
      return;
    }
    if (isUpload && !file) {
      alert("Vui lòng chọn file CV!");
      return;
    }
    const formData = new FormData();
    if (isUpload) {
      formData.append("cv", file);
      formData.append("fname", file.name);
    } else {
      formData.append("resume_id", selectedResumeId);
    }

    await jobApi.apply(id, formData);
    alert("Ứng tuyển thành công!");
    window.location.reload();
  };

  const handleCancelApplying = async () => {
    const choice = window.confirm("Bạn muốn hủy ứng tuyển vị trí này?");
    if (!choice) return;
    await jobApi.cancelApplying(id);
    setIsApplied(false);
    setApplyStatus("");
    alert("Đã hủy ứng tuyển!");
  };

  const getFileInf = (e) => {
    setFile(e.target.files[0]);
  };
  const checkLoggedIn = () => {
    if (!isAuth) {
      alert("Vui lòng đăng nhập!");
    }
  };
  const checkJobSaved = async () => {
    const res = await candidateApi.checkJobSaved(id);
    setIsSaved(res.value);
    console.log("save job?:", res.value);
  };
  const getResumes = async () => {
    const res = await resumeApi.getByCurrentCandidate();
    setResumes(res);
    if (res.length > 0) setSelectedResumeId(res[0].id);
  };
  const handleClickSaveBtn = async (status) => {
    const data = { status: status };
    await candidateApi.processJobSaving(id, data);
    setIsSaved(!isSaved);
    setTimeout(() => {
      alert("Cập nhật thành công!");
    }, 100);
  };

  useEffect(() => {
    getJobInf();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);
  useEffect(() => {
    if (isAuth) {
      checkApplying();
      checkJobSaved();
      getResumes();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [isAuth]);

  return (
    <div style={{ margin: "0 10%" }}>
      <div className="container image-container d-flex justify-content-center">
        <img
          src={job.employer.image || bannerFallback}
          className="mx-auto d-block mt-3"
          style={{ maxWidth: "93%", maxHeight: "400px" }}
          alt={"com-img-" + job.employer.id}
          onError={useBannerFallback}
        />
      </div>
      <div className="d-flex mt-3">
        <div className="left-part">
          <div className="bg-white shadow-sm pb-4">
            <div className="d-flex border-bottom ps-4 pe-4">
              <div
                className="d-flex align-items-center ms-2 mt-4 mb-3"
                style={{ minWidth: "130px" }}
              >
                <img
                  src={job.employer.logo || logoFallback}
                  width="100%"
                  alt={job.employer.name}
                  onError={useLogoFallback}
                />
              </div>
              <div className="container pt-2" style={{ marginLeft: "25px" }}>
                <div>
                  <div className="">
                    <h4 className="mt-3">{job.jname}</h4>
                    {/* <p className="text-secondary">{job.employer.name}</p> */}
                  </div>
                  <div className="clearfix mt-3 mb-2">
                    <button
                      className="btn btn-primary ts-sm"
                      data-bs-toggle={isAuth ? "modal" : ""}
                      data-bs-target={isAuth ? "#applying_dialog" : ""}
                      disabled={isApplied === true || isExpired}
                      onClick={checkLoggedIn}
                    >
                      {isExpired
                        ? "Hết hạn ứng tuyển"
                        : isApplied === true
                        ? statusText[applyStatus] || "Đã ứng tuyển"
                        : "Ứng tuyển"}
                    </button>
                    {isApplied && applyStatus === "pending" && (
                      <button
                        className="btn border-warning text-warning ms-3 ts-sm"
                        onClick={handleCancelApplying}
                      >
                        Hủy ứng tuyển
                      </button>
                    )}
                    <button
                      className="btn border-danger text-danger ms-5 ts-sm"
                      onClick={() => handleClickSaveBtn(!isSaved)}
                    >
                      {!isSaved ? (
                        <div>
                          <AiOutlineHeart className="fs-5" /> Lưu việc làm
                        </div>
                      ) : (
                        <div>
                          <AiFillHeart className="fs-5" /> Hủy lưu việc làm
                        </div>
                      )}
                    </button>
                    <div className="mt-2 d-flex gap-2 flex-wrap">
                      {isApplied && (
                        <span className="badge bg-main">
                          {statusText[applyStatus] || "Đã ứng tuyển"}
                        </span>
                      )}
                      {isSaved && <span className="badge bg-danger">Đã lưu việc</span>}
                      {isExpired && <span className="badge bg-secondary">Đã hết hạn</span>}
                    </div>
                    {isAuth && (
                      <div className="modal fade" id="applying_dialog">
                        <div
                          className="modal-dialog modal-lg modal-fullscreen-sm-down modal-dialog-scrollable"
                          style={{ width: "60%" }}
                        >
                          <div className="modal-content">
                            <div className="modal-header border-bottom-0">
                              <button
                                type="button"
                                className="btn-close btn btn-sm"
                                data-bs-dismiss="modal"
                              ></button>
                            </div>
                            <div className="modal-body ps-5">
                              <div className="">
                                <span style={{ fontSize: "15px" }}>
                                  Ứng tuyển vào vị trí
                                </span>
                                <br />
                                <h4>{job.jname}</h4>
                                <span
                                  className="text-secondary"
                                  style={{ fontSize: "15px" }}
                                >
                                  {job.employer.name}
                                </span>
                              </div>

                              <form className="mt-3" style={{ width: "65%" }}>
                                <div>
                                  <label htmlFor="fullname">Họ và tên</label>
                                  <input
                                    type="text"
                                    className="form-control"
                                    name="fullname"
                                    placeholder={
                                      user &&
                                      user.name.lastname +
                                        " " +
                                        user.name.firstname
                                    }
                                    disabled
                                  />
                                </div>
                                <div className="mt-2">
                                  <label htmlFor="email">Email</label>
                                  <input
                                    type="text"
                                    className="form-control"
                                    name="email"
                                    placeholder={user && user.email}
                                    disabled
                                  />
                                </div>
                              </form>
                              <div className="mt-3">
                                Hồ sơ của bạn:
                                <br />
                                <div className="">
                                  {resumes.length > 0 && (
                                    <select
                                      className="form-select mt-2 w-50"
                                      value={selectedResumeId}
                                      disabled={isUpload}
                                      onChange={(e) =>
                                        setSelectedResumeId(e.target.value)
                                      }
                                    >
                                      {resumes.map((resume) => (
                                        <option
                                          key={`resume_option_${resume.id}`}
                                          value={resume.id}
                                        >
                                          {resume.title || `CV #${resume.id}`}
                                        </option>
                                      ))}
                                    </select>
                                  )}
                                  <button
                                    type="button"
                                    className="btn btn-outline-primary mt-2 w-50"
                                    disabled={isUpload && true}
                                    onClick={() => {
                                      document
                                        .getElementById("close-dialog-btn")
                                        .click();
                                      nav("/candidate/resumes");
                                    }}
                                  >
                                    <AiOutlinePlus /> Tạo hồ sơ trực tuyến
                                  </button>
                                  <br />
                                  <button
                                    type="button"
                                    className="btn btn-outline-primary mt-3 w-50"
                                    onClick={() => {
                                      setIsUpload(!isUpload);
                                      setFile(undefined);
                                    }}
                                  >
                                    <BsUpload />{" "}
                                    {isUpload
                                      ? "Dùng CV trong hệ thống"
                                      : "Tải lên hồ sơ có sẵn"}
                                  </button>
                                  {isUpload && (
                                    <div>
                                      <input
                                        type="file"
                                        className="form-control mt-3 w-50"
                                        onChange={getFileInf}
                                      />
                                    </div>
                                  )}
                                </div>
                              </div>
                            </div>
                            <div className="modal-footer border-top-0">
                              <button
                                type="button"
                                className="btn btn-primary"
                                onClick={handleApply}
                              >
                                Nộp hồ sơ
                              </button>
                              <button
                                id="close-dialog-btn"
                                type="button"
                                className="btn btn-danger"
                                data-bs-dismiss="modal"
                              >
                                Đóng
                              </button>
                            </div>
                          </div>
                        </div>
                      </div>
                    )}
                  </div>
                </div>
              </div>
            </div>
            <div className="row row-cols-2 row-cols-lg-3 p-3 ps-5 ts-smd">
              <div className="d-flex mb-2 border-bottom pb-1">
                <div>
                  <FaIndustry className="text-main me-2 mb-1" />
                </div>
                <div>
                  <div className="text-main">Ngành nghề</div>
                  <div className="ts-sm fw-500">
                    {industries.map((item, index) => (
                      <span key={"industry" + item.id}>
                        {item.name}
                        {index !== industries.length - 1 ? ", " : null}
                      </span>
                    ))}
                  </div>
                </div>
              </div>
              <div className="d-flex mb-2 border-bottom pb-1">
                <div>
                  <MdOutlineAttachMoney className="fs-5 text-main mb-1" />
                </div>
                <div>
                  <div className="text-main">Lương</div>
                  <div className="fw-500">
                    {job.min_salary ? (
                      <span>
                        {job.min_salary} - {job.max_salary} triệu VND
                      </span>
                    ) : (
                      <span>Cạnh tranh</span>
                    )}
                  </div>
                </div>
              </div>
              <div className="d-flex mb-2 border-bottom pb-1">
                <div>
                  <BsFillBriefcaseFill className="ts-md text-main me-2 mb-1" />
                </div>
                <div>
                  <div className="text-main">Kinh nghiệm</div>
                  <div className="fw-500">
                    {job.yoe ? (
                      <span>{job.yoe} năm</span>
                    ) : (
                      <span>Không yêu cầu</span>
                    )}
                  </div>
                </div>
              </div>
              <div className="d-flex mb-2 border-bottom pb-1">
                <div>
                  <BsFillPeopleFill className="text-main me-1 mb-1" />
                </div>
                <div>
                  <div className="text-main">Số lượng</div>
                  <span className="fw-500">{job.amount} người</span>
                </div>
              </div>
              <div className="d-flex mb-2 border-bottom pb-1">
                <div>
                  <BsPersonWorkspace className="text-main me-2 mb-1" />
                </div>
                <div>
                  <div className="text-main">Hình thức</div>
                  <span className="fw-500">{job.jtype.name}</span>
                </div>
              </div>
              <div className="d-flex mb-2 border-bottom pb-1">
                <div>
                  <BsFillPersonFill className="text-main me-2 mb-1" />
                </div>
                <div>
                  <div className="text-main">Cấp bậc</div>
                  <span className="fw-500">{job.jlevel.name}</span>
                </div>
              </div>
              <div className="d-flex border-bottom pb-1">
                <div>
                  <BsCalendarEvent className="text-main me-2 mb-1" />
                </div>
                <div>
                  <div className="text-main">Ngày đăng</div>
                  <span className="fw-500">
                    {dayjs(job.created_at).format("DD/MM/YYYY")}
                  </span>
                </div>
              </div>
              <div className="d-flex border-bottom pb-1">
                <div>
                  <BsCalendar2Check className="text-main me-2 mb-1" />
                </div>
                <div>
                  <div className="text-main"> Hạn nộp</div>
                  <span className="fw-500">
                    {dayjs(job.expire_at).format("DD/MM/YYYY")}
                  </span>
                </div>
              </div>
            </div>
          </div>
          <div className="bg-white mt-4 mb-5 shadow-sm">
            <h5 className="bg-main text-white p-3">Chi tiết về job</h5>
            <div className="p-3">
              {job.description ? (
                <div className="whitespace-preline">{job.description}</div>
              ) : (
                "Chưa cập nhật thông tin"
              )}
            </div>
          </div>
        </div>
        <div className="right-part ps-3">
          <div className="bg-white pb-2 shadow-sm">
            <div className="d-flex align-items-center ms-2">
              <div
                className="d-flex align-items-center"
                style={{ width: "90px", height: "90px" }}
              >
                <img
                  src={job.employer.logo || logoFallback}
                  width="100%"
                  alt={job.employer.name}
                  onError={useLogoFallback}
                />
              </div>
              <div className="fw-bold ms-2">{job.employer.name}</div>
            </div>
            <div className="mx-2 ts-smd">
              <div className="d-flex">
                <div
                  className="d-flex align-items-center text-secondary"
                  style={{ minWidth: "90px" }}
                >
                  <IoMdPeople className="fs-5 me-1" />
                  Quy mô:
                </div>
                <div>
                  {job.employer.min_employees ? (
                    <>
                      {job.employer.min_employees}
                      {job.employer.max_employees !== 0
                        ? " - " + job.employer.max_employees
                        : "+ "}{" "}
                      nhân viên
                    </>
                  ) : (
                    "Chưa cập nhật"
                  )}
                </div>
              </div>
              <div className="d-flex">
                <div className="text-secondary" style={{ minWidth: "90px" }}>
                  Website:
                </div>
                <div className="text-truncate">
                  {job.employer.website ? (
                    <a
                      href={job.employer.website}
                      target="_blank"
                      rel="noreferrer"
                    >
                      {job.employer.website}
                    </a>
                  ) : (
                    "Chưa cập nhật"
                  )}
                </div>
              </div>
              <div className="d-flex">
                <div className="text-secondary" style={{ minWidth: "90px" }}>
                  <BsFillGeoAltFill className="me-1 mb-1" />
                  Địa điểm:
                </div>
                <div
                  className="whitespace-preline"
                  style={{ fontSize: "14.5px" }}
                >
                  {job.address}
                </div>
              </div>
              <Button
                size="sm"
                className="container-fluid mt-1 bg-main"
                onClick={() => nav(`/companies/${job.employer.id}`)}
              >
                Xem trang công ty
              </Button>
            </div>
          </div>
          <div className="bg-white mt-3 p-3 shadow-sm">
            <h6 className="text-main mb-3">Việc làm tương tự</h6>
            {job.similar_jobs?.length > 0 ? (
              job.similar_jobs.map((item) => (
                <div
                  key={`similar_job_${item.id}`}
                  className="border-bottom pb-2 mb-2 pointer"
                  onClick={() => nav(`/jobs/${item.id}`)}
                >
                  <div className="fw-600 hover-text-main">{item.jname}</div>
                  <div className="ts-smd text-secondary text-truncate">
                    {item.employer?.name}
                  </div>
                  <div className="ts-sm">
                    {item.min_salary
                      ? `${item.min_salary} - ${item.max_salary} triệu VND`
                      : "Lương thỏa thuận"}
                  </div>
                </div>
              ))
            ) : (
              <div className="ts-smd text-secondary">Chưa có gợi ý phù hợp</div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}

export default Job;

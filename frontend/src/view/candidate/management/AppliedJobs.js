import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { useSelector } from "react-redux";
import candidateApi from "../../../api/candidate";
import jobApi from "../../../api/job";

function AppliedJobs() {
  const nav = useNavigate();
  const [jobs, setJobs] = useState([]);
  const user = useSelector((state) => state.candAuth.current);
  const isAuth = useSelector((state) => state.candAuth.isAuth);

  const getAppliedJobs = async () => {
    const res = await candidateApi.getAppliedJobs(user.id);
    setJobs(res);
  };

  const statusText = {
    pending: "Đã nộp",
    viewed: "Nhà tuyển dụng đã xem",
    suitable: "Phù hợp",
    rejected: "Từ chối",
    interview: "Mời phỏng vấn",
    cancelled: "Đã hủy",
    WAITING: "Đã nộp",
    BROWSING_RESUME: "Nhà tuyển dụng đã xem",
    RESUME_FAILED: "Từ chối",
    BROWSING_INTERVIEW: "Mời phỏng vấn",
    INTERVIEW_FAILED: "Từ chối sau phỏng vấn",
    PASSED: "Phù hợp",
  };

  const handleCancel = async (jobId) => {
    const choice = window.confirm("Bạn muốn hủy ứng tuyển công việc này?");
    if (!choice) return;
    await jobApi.cancelApplying(jobId);
    await getAppliedJobs();
  };

  useEffect(() => {
    if (isAuth) {
      getAppliedJobs();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [isAuth]);

  return (
    <>
      <div className="mx-4 mt-4 px-5 py-3 bg-white">
        <h4 className="mb-4 text-main">Việc làm đã nộp</h4>
        <table className="table border shadow-sm">
          <thead className="table-primary">
            <tr>
              <th className="fw-500" style={{ width: "28%" }}>
                Vị trí
              </th>
              <th className="fw-500" style={{ width: "26%" }}>
                Công ty
              </th>
              <th className="fw-500" style={{ width: "13%" }}>
                Ngày nộp
              </th>
              <th className="fw-500" style={{ width: "18%" }}>
                Trạng thái
              </th>
              <th className="fw-500">Hồ sơ</th>
              <th className="fw-500">Thao tác</th>
            </tr>
          </thead>
          <tbody className="ts-smd">
            {jobs.map((item) => (
              <tr key={"job" + item.id}>
                <td>
                  <div
                    className="hover-text-main pointer"
                    onClick={() => nav(`/jobs/${item.id}`)}
                  >
                    {item.jname}
                  </div>
                </td>
                <td>{item.name}</td>
                <td>{item.postDate} </td>
                <td>
                  <span className="badge bg-main">
                    {statusText[item.status] || item.status}
                  </span>
                </td>
                <td>
                  <a
                    className=""
                    style={{ textDecoration: "none" }}
                    href={item.cv_link}
                    target="_blank"
                    rel="noreferrer"
                  >
                    Xem
                  </a>
                </td>
                <td>
                  {item.status === "pending" ? (
                    <button
                      type="button"
                      className="btn btn-sm btn-outline-danger"
                      onClick={() => handleCancel(item.id)}
                    >
                      Hủy
                    </button>
                  ) : (
                    <span className="text-secondary">-</span>
                  )}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
        {jobs.length === 0 && <h5 className="">Không có bản ghi nào</h5>}
      </div>
    </>
  );
}

export default AppliedJobs;

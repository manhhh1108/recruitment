import { useEffect, useMemo, useState } from "react";
import { useNavigate } from "react-router-dom";
import { useSelector } from "react-redux";
import { toast } from "react-toastify";
import Modal from "react-bootstrap/Modal";
import Button from "react-bootstrap/Button";
import candidateApi from "../../../api/candidate";
import jobApi from "../../../api/job";

function AppliedJobs() {
  const nav = useNavigate();
  const [jobs, setJobs] = useState([]);
  const [statusFilter, setStatusFilter] = useState("");
  const [page, setPage] = useState(1);
  const [loading, setLoading] = useState(false);
  const [cancelJob, setCancelJob] = useState(null);
  const user = useSelector((state) => state.candAuth.current);
  const isAuth = useSelector((state) => state.candAuth.isAuth);

  const getAppliedJobs = async () => {
    setLoading(true);
    const res = await candidateApi.getAppliedJobs(user.id);
    setJobs(res);
    setLoading(false);
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

  const filteredJobs = useMemo(
    () => jobs.filter((item) => !statusFilter || item.status === statusFilter),
    [jobs, statusFilter]
  );
  const perPage = 8;
  const lastPage = Math.max(Math.ceil(filteredJobs.length / perPage), 1);
  const displayedJobs = filteredJobs.slice((page - 1) * perPage, page * perPage);

  const handleCancel = async () => {
    await jobApi.cancelApplying(cancelJob.id);
    toast.success("Đã hủy ứng tuyển");
    setCancelJob(null);
    await getAppliedJobs();
  };

  useEffect(() => {
    if (isAuth) {
      getAppliedJobs();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [isAuth]);

  useEffect(() => {
    setPage(1);
  }, [statusFilter]);

  return (
    <>
      <div className="mx-4 mt-4 px-5 py-3 bg-white">
        <div className="d-flex flex-wrap justify-content-between align-items-center mb-4">
          <h4 className="text-main mb-0">Việc làm đã nộp</h4>
          <select
            className="form-select form-select-sm"
            style={{ width: "220px" }}
            value={statusFilter}
            onChange={(e) => setStatusFilter(e.target.value)}
          >
            <option value="">Tất cả trạng thái</option>
            <option value="pending">Đã nộp</option>
            <option value="viewed">Nhà tuyển dụng đã xem</option>
            <option value="interview">Mời phỏng vấn</option>
            <option value="suitable">Phù hợp</option>
            <option value="rejected">Từ chối</option>
            <option value="cancelled">Đã hủy</option>
          </select>
        </div>
        {loading ? (
          <div className="text-center py-5">
            <div className="spinner-border text-main" />
          </div>
        ) : (
          <>
            <div className="table-responsive">
              <table className="table border shadow-sm">
                <thead className="table-primary">
                  <tr>
                    <th className="fw-500" style={{ width: "28%" }}>Vị trí</th>
                    <th className="fw-500" style={{ width: "26%" }}>Công ty</th>
                    <th className="fw-500" style={{ width: "13%" }}>Ngày nộp</th>
                    <th className="fw-500" style={{ width: "18%" }}>Trạng thái</th>
                    <th className="fw-500">Hồ sơ</th>
                    <th className="fw-500">Thao tác</th>
                  </tr>
                </thead>
                <tbody className="ts-smd">
                  {displayedJobs.map((item) => (
                    <tr key={"job" + item.id}>
                      <td>
                        <div className="hover-text-main pointer" onClick={() => nav(`/jobs/${item.id}`)}>
                          {item.jname}
                        </div>
                      </td>
                      <td>{item.name}</td>
                      <td>{item.postDate} </td>
                      <td><span className="badge bg-main">{statusText[item.status] || item.status}</span></td>
                      <td><a className="text-decoration-none" href={item.cv_link} target="_blank" rel="noreferrer">Xem</a></td>
                      <td>
                        {item.status === "pending" ? (
                          <button type="button" className="btn btn-sm btn-outline-danger" onClick={() => setCancelJob(item)}>Hủy</button>
                        ) : (
                          <span className="text-secondary">-</span>
                        )}
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
            {filteredJobs.length === 0 && (
              <div className="border bg-mlight p-4 text-center">Không có việc làm phù hợp với bộ lọc hiện tại</div>
            )}
            {filteredJobs.length > perPage && (
              <div className="d-flex gap-2 justify-content-end">
                <button className="btn btn-sm btn-outline-primary" disabled={page <= 1} onClick={() => setPage(page - 1)}>Trước</button>
                <span className="ts-smd py-1">Trang {page}/{lastPage}</span>
                <button className="btn btn-sm btn-outline-primary" disabled={page >= lastPage} onClick={() => setPage(page + 1)}>Sau</button>
              </div>
            )}
          </>
        )}
      </div>
      <Modal show={!!cancelJob} onHide={() => setCancelJob(null)}>
        <Modal.Header closeButton><Modal.Title>Xác nhận hủy</Modal.Title></Modal.Header>
        <Modal.Body>Bạn muốn hủy ứng tuyển công việc "{cancelJob?.jname}"?</Modal.Body>
        <Modal.Footer>
          <Button variant="outline-secondary" onClick={() => setCancelJob(null)}>Không</Button>
          <Button variant="danger" onClick={handleCancel}>Hủy ứng tuyển</Button>
        </Modal.Footer>
      </Modal>
    </>
  );
}

export default AppliedJobs;

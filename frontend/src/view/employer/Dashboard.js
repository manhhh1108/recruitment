import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { BsBriefcase, BsClockHistory, BsPeople, BsPersonPlus } from "react-icons/bs";
import employerApi from "../../api/employer";

function MiniBars({ items = [], labelKey = "month", statusText = {} }) {
  const max = Math.max(...items.map((item) => Number(item.total)), 1);

  return (
    <div className="border p-3 h-100">
      <div className="fw-600 text-main mb-3">Thống kê ứng tuyển</div>
      {items.length === 0 && <div className="text-secondary">Chưa có dữ liệu</div>}
      {items.map((item) => (
        <div className="d-flex align-items-center gap-2 mb-2" key={item[labelKey]}>
          <div className="ts-sm text-secondary" style={{ width: "94px" }}>
            {statusText[item[labelKey]] || item[labelKey]}
          </div>
          <div className="progress flex-fill" style={{ height: "10px" }}>
            <div className="progress-bar bg-main" style={{ width: `${(item.total / max) * 100}%` }} />
          </div>
          <div className="fw-600 ts-sm" style={{ width: "28px" }}>{item.total}</div>
        </div>
      ))}
    </div>
  );
}

function Dashboard() {
  const nav = useNavigate();
  const [data, setData] = useState({
    total_jobs: 0,
    active_jobs: 0,
    expired_jobs: 0,
    inactive_jobs: 0,
    total_applications: 0,
    new_applications_this_week: 0,
    recent_applications: [],
    applications_by_month: [],
    applications_by_status: [],
    applications_by_job: [],
    expiring_jobs: [],
    status_conversion: [],
    applications_by_source: [],
  });

  const getDashboard = async () => {
    const res = await employerApi.getDashboard();
    setData(res);
  };

  useEffect(() => {
    getDashboard();
  }, []);

  const stats = [
    { label: "Tổng tin tuyển dụng", value: data.total_jobs, icon: <BsBriefcase /> },
    { label: "Tin đang hoạt động", value: data.active_jobs, icon: <BsBriefcase /> },
    { label: "Tin đã hết hạn", value: data.expired_jobs, icon: <BsClockHistory /> },
    { label: "Tin đang tắt", value: data.inactive_jobs, icon: <BsClockHistory /> },
    { label: "Tổng ứng viên", value: data.total_applications, icon: <BsPeople /> },
    { label: "Ứng viên mới trong tuần", value: data.new_applications_this_week, icon: <BsPersonPlus /> },
  ];

  const statusText = {
    pending: "Đã nộp",
    viewed: "Đã xem",
    suitable: "Phù hợp",
    rejected: "Từ chối",
    interview: "Mời phỏng vấn",
    cancelled: "Đã hủy",
  };

  return (
    <div className="bg-white ms-4 mt-3 px-5 py-3" style={{ minHeight: "90%" }}>
      <h5 className="mb-4 text-main">Dashboard nhà tuyển dụng</h5>
      <div className="row row-cols-1 row-cols-md-3 g-3" style={{ width: "93%" }}>
        {stats.map((item) => (
          <div className="col" key={item.label}>
            <div className="border bg-mlight p-3 h-100">
              <div className="d-flex justify-content-between align-items-center">
                <div>
                  <div className="text-secondary ts-smd">{item.label}</div>
                  <div className="fs-4 fw-600 text-main">{item.value}</div>
                </div>
                <div className="fs-3 text-main">{item.icon}</div>
              </div>
            </div>
          </div>
        ))}
      </div>
      <div className="row g-3 mt-2" style={{ width: "93%" }}>
        <div className="col-md-6">
          <MiniBars items={data.applications_by_month} />
        </div>
        <div className="col-md-6">
          <MiniBars items={data.applications_by_status} labelKey="status" statusText={statusText} />
        </div>
      </div>
      <div className="row g-3 mt-2" style={{ width: "93%" }}>
        <div className="col-md-6">
          <div className="border p-3 h-100">
            <div className="fw-600 text-main mb-3">Ứng tuyển theo tin</div>
            {data.applications_by_job.length === 0 && <div className="text-secondary">Chưa có dữ liệu</div>}
            {data.applications_by_job.map((item) => (
              <div className="d-flex justify-content-between border-bottom py-2" key={item.id}>
                <span className="text-truncate me-2">{item.jname}</span>
                <span className="fw-600 text-main">{item.total}</span>
              </div>
            ))}
          </div>
        </div>
        <div className="col-md-6">
          <div className="border p-3 h-100">
            <div className="fw-600 text-main mb-3">Tin sắp hết hạn</div>
            {data.expiring_jobs.length === 0 && <div className="text-secondary">Không có tin sắp hết hạn</div>}
            {data.expiring_jobs.map((item) => (
              <div className="d-flex justify-content-between border-bottom py-2" key={item.id}>
                <span className="text-truncate me-2">{item.jname}</span>
                <span className="badge bg-warning text-dark">Còn {item.days_left} ngày</span>
              </div>
            ))}
          </div>
        </div>
      </div>
      <div className="border p-3 mt-3" style={{ width: "93%" }}>
        <div className="fw-600 text-main mb-3">Tỷ lệ trạng thái ứng tuyển</div>
        <div className="d-flex flex-wrap gap-2">
          {data.status_conversion.map((item) => (
            <span className="border bg-mlight px-3 py-2 ts-smd" key={item.status}>
              {statusText[item.status] || item.status}: <span className="fw-600">{item.percent}%</span>
            </span>
          ))}
        </div>
        {data.status_conversion.length === 0 && <div className="text-secondary">Chưa có dữ liệu</div>}
      </div>
      <div className="border p-3 mt-3" style={{ width: "93%" }}>
        <div className="fw-600 text-main mb-3">Nguồn ứng viên</div>
        <div className="d-flex flex-wrap gap-2">
          {data.applications_by_source.map((item) => (
            <span className="border bg-mlight px-3 py-2 ts-smd" key={item.source}>
              {item.source}: <span className="fw-600">{item.total}</span>
            </span>
          ))}
        </div>
        {data.applications_by_source.length === 0 && <div className="text-secondary">Chưa có dữ liệu</div>}
      </div>
      <div className="d-flex justify-content-between align-items-center mt-4" style={{ width: "93%" }}>
        <h5 className="text-main mb-0">Ứng viên mới nhất</h5>
        <button
          className="btn btn-sm btn-outline-primary"
          onClick={() => nav("/employer/candidates")}
        >
          Xem tất cả
        </button>
      </div>
      <div className="table-responsive" style={{ width: "93%" }}>
      <table className="table border text-center shadow-sm mt-3">
        <thead className="table-primary ts-smd">
          <tr>
            <th>Ứng viên</th>
            <th>Email</th>
            <th>Vị trí</th>
            <th>Ngày nộp</th>
            <th>Trạng thái</th>
          </tr>
        </thead>
        <tbody className="ts-smd">
          {data.recent_applications.map((item) => (
            <tr key={`${item.job_id}_${item.candidate_id}`}>
              <td>{item.lastname + " " + item.firstname}</td>
              <td>{item.email}</td>
              <td>{item.jname}</td>
              <td>{item.appliedTime}</td>
              <td>
                <span className="badge bg-main">
                  {statusText[item.status] || item.status}
                </span>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
      </div>
      {data.recent_applications.length === 0 && (
        <div className="border bg-mlight p-4 text-center" style={{ width: "93%" }}>
          Chưa có ứng viên mới
        </div>
      )}
    </div>
  );
}

export default Dashboard;

import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import candidateApi from "../../../api/candidate";

function Dashboard() {
  const nav = useNavigate();
  const [data, setData] = useState({
    applied_count: 0,
    saved_count: 0,
    resume_count: 0,
    profile_percent: 0,
    job_search_status: "Chưa cập nhật",
    recommended_jobs: [],
  });

  const getDashboard = async () => {
    const res = await candidateApi.getDashboard();
    setData(res);
  };

  useEffect(() => {
    getDashboard();
  }, []);

  const stats = [
    { label: "Việc đã ứng tuyển", value: data.applied_count },
    { label: "Việc đã lưu", value: data.saved_count },
    { label: "CV đã tạo", value: data.resume_count },
    { label: "Hoàn thiện hồ sơ", value: `${data.profile_percent}%` },
  ];

  return (
    <div className="mx-4 mt-4 px-5 py-3 bg-white">
      <h4 className="mb-4 text-main">Dashboard ứng viên</h4>
      <div className="row row-cols-1 row-cols-md-4 g-3">
        {stats.map((item) => (
          <div className="col" key={item.label}>
            <div className="border bg-mlight p-3 h-100">
              <div className="text-secondary ts-smd">{item.label}</div>
              <div className="fs-4 fw-600 text-main">{item.value}</div>
            </div>
          </div>
        ))}
      </div>
      <div className="mt-4 border p-3">
        <div className="d-flex justify-content-between align-items-center">
          <div>
            <div className="fw-600 text-main">Trạng thái hồ sơ</div>
            <div className="text-secondary ts-smd">
              {data.job_search_status}
            </div>
          </div>
          <button
            className="btn btn-sm btn-outline-primary"
            onClick={() => nav("/candidate/profile")}
          >
            Cập nhật hồ sơ
          </button>
        </div>
        <div className="progress mt-3" style={{ height: "8px" }}>
          <div
            className="progress-bar bg-main"
            role="progressbar"
            style={{ width: `${data.profile_percent}%` }}
            aria-valuenow={data.profile_percent}
            aria-valuemin="0"
            aria-valuemax="100"
          />
        </div>
      </div>
      <div className="mt-4">
        <h5 className="text-main mb-3">Việc làm phù hợp với hồ sơ của bạn</h5>
        <table className="table border shadow-sm">
          <thead className="table-primary">
            <tr>
              <th>Vị trí</th>
              <th>Công ty</th>
              <th>Lương</th>
              <th>Địa điểm</th>
            </tr>
          </thead>
          <tbody className="ts-smd">
            {data.recommended_jobs.map((job) => (
              <tr
                key={`recommended_${job.id}`}
                className="pointer"
                onClick={() => nav(`/jobs/${job.id}`)}
              >
                <td className="hover-text-main">{job.jname}</td>
                <td>{job.employer?.name}</td>
                <td>
                  {job.min_salary
                    ? `${job.min_salary} - ${job.max_salary} triệu`
                    : "Thỏa thuận"}
                </td>
                <td>
                  {job.locations?.map((item) => item.name).join(", ") ||
                    "Chưa cập nhật"}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
        {data.recommended_jobs.length === 0 && (
          <h5>Chưa có việc làm gợi ý phù hợp</h5>
        )}
      </div>
    </div>
  );
}

export default Dashboard;

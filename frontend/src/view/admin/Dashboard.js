import { useEffect, useState } from "react";
import adminApi from "../../api/admin";

const categoryTypes = [
  { type: "industries", label: "Ngành nghề" },
  { type: "locations", label: "Địa điểm" },
  { type: "jtypes", label: "Hình thức" },
  { type: "jlevels", label: "Cấp bậc" },
];

function AdminDashboard() {
  const [dashboard, setDashboard] = useState({});
  const [users, setUsers] = useState([]);
  const [jobs, setJobs] = useState([]);
  const [categoryType, setCategoryType] = useState("industries");
  const [categories, setCategories] = useState([]);
  const [categoryName, setCategoryName] = useState("");

  const statusText = { 0: "Admin", 1: "Ứng viên", 2: "Nhà tuyển dụng" };

  const loadDashboard = async () => setDashboard(await adminApi.getDashboard());
  const loadUsers = async () => setUsers((await adminApi.getUsers()).data || []);
  const loadJobs = async () => setJobs((await adminApi.getJobs()).data || []);
  const loadCategories = async (type = categoryType) =>
    setCategories(await adminApi.getCategories(type));

  useEffect(() => {
    loadDashboard();
    loadUsers();
    loadJobs();
    loadCategories();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const toggleUser = async (user) => {
    await adminApi.toggleUser(user.id, user.is_active ? 0 : 1);
    loadUsers();
  };

  const toggleJob = async (job) => {
    await adminApi.toggleJob(job.id, job.is_active ? 0 : 1);
    loadJobs();
    loadDashboard();
  };

  const createCategory = async () => {
    if (!categoryName.trim()) return;
    await adminApi.createCategory(categoryType, categoryName.trim());
    setCategoryName("");
    loadCategories();
  };

  const stats = [
    ["Người dùng", dashboard.users],
    ["Ứng viên", dashboard.candidates],
    ["Nhà tuyển dụng", dashboard.employers],
    ["Công ty", dashboard.companies],
    ["Tin tuyển dụng", dashboard.jobs],
    ["Lượt ứng tuyển", dashboard.applications],
  ];

  return (
    <div className="bg-white ms-4 mt-3 px-5 py-3" style={{ minHeight: "90%" }}>
      <h5 className="mb-4 text-main">Dashboard admin</h5>
      <div className="row row-cols-1 row-cols-md-3 g-3" style={{ width: "93%" }}>
        {stats.map(([label, value]) => (
          <div className="col" key={label}>
            <div className="border bg-mlight p-3">
              <div className="text-secondary ts-smd">{label}</div>
              <div className="fs-4 fw-600 text-main">{value || 0}</div>
            </div>
          </div>
        ))}
      </div>

      <h5 className="text-main mt-4">Quản lý người dùng</h5>
      <table className="table border shadow-sm" style={{ width: "93%" }}>
        <thead className="table-primary">
          <tr>
            <th>Email</th>
            <th>Vai trò</th>
            <th>Trạng thái</th>
            <th>Thao tác</th>
          </tr>
        </thead>
        <tbody className="ts-smd">
          {users.map((user) => (
            <tr key={user.id}>
              <td>{user.email}</td>
              <td>{statusText[user.role]}</td>
              <td>{user.is_active ? "Đang mở" : "Đã khóa"}</td>
              <td>
                <button className="btn btn-sm btn-outline-primary" onClick={() => toggleUser(user)}>
                  {user.is_active ? "Khóa" : "Mở"}
                </button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>

      <h5 className="text-main mt-4">Duyệt tin tuyển dụng</h5>
      <table className="table border shadow-sm" style={{ width: "93%" }}>
        <thead className="table-primary">
          <tr>
            <th>Tin tuyển dụng</th>
            <th>Công ty</th>
            <th>Trạng thái</th>
            <th>Thao tác</th>
          </tr>
        </thead>
        <tbody className="ts-smd">
          {jobs.map((job) => (
            <tr key={job.id}>
              <td>{job.jname}</td>
              <td>{job.employer?.name}</td>
              <td>{job.is_active ? "Đang bật" : "Đang tắt"}</td>
              <td>
                <button className="btn btn-sm btn-outline-primary" onClick={() => toggleJob(job)}>
                  {job.is_active ? "Tắt" : "Duyệt/Bật"}
                </button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>

      <h5 className="text-main mt-4">Quản lý danh mục</h5>
      <div className="d-flex gap-2 mb-3">
        <select
          className="form-select"
          style={{ width: "220px" }}
          value={categoryType}
          onChange={(e) => {
            setCategoryType(e.target.value);
            loadCategories(e.target.value);
          }}
        >
          {categoryTypes.map((item) => (
            <option value={item.type} key={item.type}>
              {item.label}
            </option>
          ))}
        </select>
        <input
          className="form-control"
          style={{ width: "320px" }}
          value={categoryName}
          onChange={(e) => setCategoryName(e.target.value)}
          placeholder="Tên danh mục mới"
        />
        <button className="btn btn-primary" onClick={createCategory}>
          Thêm
        </button>
      </div>
      <div className="d-flex flex-wrap gap-2 pb-4" style={{ width: "93%" }}>
        {categories.map((item) => (
          <span className="border bg-mlight px-3 py-2 ts-smd" key={item.id}>
            {item.name}
          </span>
        ))}
      </div>
    </div>
  );
}

export default AdminDashboard;

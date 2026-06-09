import { useEffect, useState } from "react";
import { toast } from "react-toastify";
import {
  BsBriefcase,
  BsCheckCircle,
  BsEye,
  BsPencil,
  BsPeople,
  BsSearch,
  BsTrash,
} from "react-icons/bs";
import adminApi from "../../api/admin";

const categoryTypes = [
  { type: "industries", label: "Ngành nghề" },
  { type: "locations", label: "Địa điểm" },
  { type: "jtypes", label: "Hình thức" },
  { type: "jlevels", label: "Cấp bậc" },
];

const roleText = { 0: "Admin", 1: "Ứng viên", 2: "Nhà tuyển dụng" };
const statusText = {
  pending: "Đã nộp",
  viewed: "Đã xem",
  interview: "Mời phỏng vấn",
  suitable: "Phù hợp",
  rejected: "Từ chối",
};

function MiniBars({ items = [], labelKey = "month" }) {
  const max = Math.max(...items.map((item) => Number(item.total)), 1);

  return (
    <div className="border p-3 h-100">
      <div className="fw-600 text-main mb-3">Biểu đồ ứng tuyển</div>
      {items.length === 0 && <div className="text-secondary">Chưa có dữ liệu</div>}
      {items.map((item) => (
        <div className="d-flex align-items-center gap-2 mb-2" key={item[labelKey]}>
          <div className="ts-sm text-secondary" style={{ width: "92px" }}>
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

function AdminDashboard() {
  const [dashboard, setDashboard] = useState({});
  const [users, setUsers] = useState({ data: [], current_page: 1, last_page: 1 });
  const [jobs, setJobs] = useState({ data: [], current_page: 1, last_page: 1 });
  const [userFilters, setUserFilters] = useState({ keyword: "", role: "", is_active: "", page: 1 });
  const [jobFilters, setJobFilters] = useState({ keyword: "", is_active: "", page: 1 });
  const [categoryType, setCategoryType] = useState("industries");
  const [categories, setCategories] = useState([]);
  const [categoryName, setCategoryName] = useState("");
  const [editingCategory, setEditingCategory] = useState(null);
  const [selected, setSelected] = useState(null);
  const [confirm, setConfirm] = useState(null);
  const [loading, setLoading] = useState(true);

  const loadDashboard = async () => setDashboard(await adminApi.getDashboard());
  const loadUsers = async (params = userFilters) => setUsers(await adminApi.getUsers(params));
  const loadJobs = async (params = jobFilters) => setJobs(await adminApi.getJobs(params));
  const loadCategories = async (type = categoryType) => setCategories(await adminApi.getCategories(type));

  useEffect(() => {
    Promise.all([loadDashboard(), loadUsers(), loadJobs(), loadCategories()]).finally(() => setLoading(false));
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const setUserPage = (page) => {
    const params = { ...userFilters, page };
    setUserFilters(params);
    loadUsers(params);
  };

  const setJobPage = (page) => {
    const params = { ...jobFilters, page };
    setJobFilters(params);
    loadJobs(params);
  };

  const toggleUser = async (user) => {
    try {
      await adminApi.toggleUser(user.id, user.is_active ? 0 : 1);
      toast.success("Cập nhật người dùng thành công");
      loadUsers();
    } catch (e) {
      toast.error("Không thể khóa tài khoản admin hiện tại");
    }
  };

  const toggleJob = async (job) => {
    await adminApi.toggleJob(job.id, job.is_active ? 0 : 1);
    toast.success("Cập nhật tin tuyển dụng thành công");
    loadJobs();
    loadDashboard();
  };

  const saveCategory = async () => {
    if (!categoryName.trim()) return;
    if (editingCategory) {
      await adminApi.updateCategory(categoryType, editingCategory.id, categoryName.trim());
      toast.success("Đã cập nhật danh mục");
    } else {
      await adminApi.createCategory(categoryType, categoryName.trim());
      toast.success("Đã thêm danh mục");
    }
    setCategoryName("");
    setEditingCategory(null);
    loadCategories();
  };

  const deleteCategory = async () => {
    await adminApi.deleteCategory(categoryType, confirm.id);
    toast.success("Đã xóa danh mục");
    setConfirm(null);
    loadCategories();
  };

  const stats = [
    { label: "Người dùng", value: dashboard.users, icon: <BsPeople /> },
    { label: "Ứng viên", value: dashboard.candidates, icon: <BsPeople /> },
    { label: "Nhà tuyển dụng", value: dashboard.employers, icon: <BsBriefcase /> },
    { label: "Công ty", value: dashboard.companies, icon: <BsBriefcase /> },
    { label: "Tin tuyển dụng", value: dashboard.jobs, icon: <BsCheckCircle /> },
    { label: "Lượt ứng tuyển", value: dashboard.applications, icon: <BsCheckCircle /> },
  ];

  return (
    <div className="bg-white ms-4 mt-3 px-5 py-3" style={{ minHeight: "90%" }}>
      <h5 className="mb-4 text-main">Dashboard admin</h5>
      {loading ? (
        <div className="text-center py-5"><div className="spinner-border text-main" /></div>
      ) : (
        <>
          <div className="row row-cols-1 row-cols-md-3 g-3" style={{ width: "93%" }}>
            {stats.map((item) => (
              <div className="col" key={item.label}>
                <div className="border bg-mlight p-3 d-flex justify-content-between align-items-center">
                  <div>
                    <div className="text-secondary ts-smd">{item.label}</div>
                    <div className="fs-4 fw-600 text-main">{item.value || 0}</div>
                  </div>
                  <div className="fs-3 text-main">{item.icon}</div>
                </div>
              </div>
            ))}
          </div>

          <div className="row g-3 mt-2" style={{ width: "93%" }}>
            <div className="col-md-6"><MiniBars items={dashboard.applications_by_month || []} /></div>
            <div className="col-md-6"><MiniBars items={dashboard.applications_by_status || []} labelKey="status" /></div>
          </div>

          <h5 className="text-main mt-4">Quản lý người dùng</h5>
          <div className="d-flex flex-wrap gap-2 mb-3" style={{ width: "93%" }}>
            <div className="input-group input-group-sm" style={{ width: "300px" }}>
              <input className="form-control" placeholder="Tìm theo email" value={userFilters.keyword} onChange={(e) => setUserFilters({ ...userFilters, keyword: e.target.value })} />
              <button className="input-group-text bg-white" onClick={() => loadUsers({ ...userFilters, page: 1 })}><BsSearch /></button>
            </div>
            <select className="form-select form-select-sm" style={{ width: "180px" }} value={userFilters.role} onChange={(e) => { const p = { ...userFilters, role: e.target.value, page: 1 }; setUserFilters(p); loadUsers(p); }}>
              <option value="">Tất cả vai trò</option>
              <option value="0">Admin</option>
              <option value="1">Ứng viên</option>
              <option value="2">Nhà tuyển dụng</option>
            </select>
            <select className="form-select form-select-sm" style={{ width: "180px" }} value={userFilters.is_active} onChange={(e) => { const p = { ...userFilters, is_active: e.target.value, page: 1 }; setUserFilters(p); loadUsers(p); }}>
              <option value="">Tất cả trạng thái</option>
              <option value="1">Đang mở</option>
              <option value="0">Đã khóa</option>
            </select>
          </div>
          <div className="table-responsive" style={{ width: "93%" }}>
            <table className="table border shadow-sm">
              <thead className="table-primary"><tr><th>Email</th><th>Vai trò</th><th>Trạng thái</th><th>Thao tác</th></tr></thead>
              <tbody className="ts-smd">
                {users.data.map((user) => (
                  <tr key={user.id}>
                    <td>{user.email}</td><td>{roleText[user.role]}</td><td>{user.is_active ? "Đang mở" : "Đã khóa"}</td>
                    <td>
                      <button className="btn btn-sm btn-outline-primary me-2" onClick={() => setSelected({ type: "user", data: user })}><BsEye /></button>
                      <button className="btn btn-sm btn-outline-primary" onClick={() => toggleUser(user)}>{user.is_active ? "Khóa" : "Mở"}</button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
          {users.data.length === 0 && <div className="border bg-mlight p-3 text-center" style={{ width: "93%" }}>Không có người dùng phù hợp</div>}
          <div className="d-flex gap-2 mb-4">
            <button className="btn btn-sm btn-outline-primary" disabled={users.current_page <= 1} onClick={() => setUserPage(users.current_page - 1)}>Trước</button>
            <span className="ts-smd py-1">Trang {users.current_page}/{users.last_page}</span>
            <button className="btn btn-sm btn-outline-primary" disabled={users.current_page >= users.last_page} onClick={() => setUserPage(users.current_page + 1)}>Sau</button>
          </div>

          <h5 className="text-main mt-4">Duyệt tin tuyển dụng</h5>
          <div className="d-flex flex-wrap gap-2 mb-3" style={{ width: "93%" }}>
            <div className="input-group input-group-sm" style={{ width: "300px" }}>
              <input className="form-control" placeholder="Tìm tin tuyển dụng" value={jobFilters.keyword} onChange={(e) => setJobFilters({ ...jobFilters, keyword: e.target.value })} />
              <button className="input-group-text bg-white" onClick={() => loadJobs({ ...jobFilters, page: 1 })}><BsSearch /></button>
            </div>
            <select className="form-select form-select-sm" style={{ width: "180px" }} value={jobFilters.is_active} onChange={(e) => { const p = { ...jobFilters, is_active: e.target.value, page: 1 }; setJobFilters(p); loadJobs(p); }}>
              <option value="">Tất cả trạng thái</option>
              <option value="1">Đang bật</option>
              <option value="0">Đang tắt</option>
            </select>
          </div>
          <div className="table-responsive" style={{ width: "93%" }}>
            <table className="table border shadow-sm">
              <thead className="table-primary"><tr><th>Tin tuyển dụng</th><th>Công ty</th><th>Trạng thái</th><th>Thao tác</th></tr></thead>
              <tbody className="ts-smd">
                {jobs.data.map((job) => (
                  <tr key={job.id}>
                    <td>{job.jname}</td><td>{job.employer?.name}</td><td>{job.is_active ? "Đang bật" : "Đang tắt"}</td>
                    <td>
                      <button className="btn btn-sm btn-outline-primary me-2" onClick={() => setSelected({ type: "job", data: job })}><BsEye /></button>
                      <button className="btn btn-sm btn-outline-primary" onClick={() => toggleJob(job)}>{job.is_active ? "Tắt" : "Duyệt/Bật"}</button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
          {jobs.data.length === 0 && <div className="border bg-mlight p-3 text-center" style={{ width: "93%" }}>Không có tin phù hợp</div>}
          <div className="d-flex gap-2 mb-4">
            <button className="btn btn-sm btn-outline-primary" disabled={jobs.current_page <= 1} onClick={() => setJobPage(jobs.current_page - 1)}>Trước</button>
            <span className="ts-smd py-1">Trang {jobs.current_page}/{jobs.last_page}</span>
            <button className="btn btn-sm btn-outline-primary" disabled={jobs.current_page >= jobs.last_page} onClick={() => setJobPage(jobs.current_page + 1)}>Sau</button>
          </div>

          <h5 className="text-main mt-4">Quản lý danh mục</h5>
          <div className="d-flex flex-wrap gap-2 mb-3">
            <select className="form-select" style={{ width: "220px" }} value={categoryType} onChange={(e) => { setCategoryType(e.target.value); setEditingCategory(null); setCategoryName(""); loadCategories(e.target.value); }}>
              {categoryTypes.map((item) => <option value={item.type} key={item.type}>{item.label}</option>)}
            </select>
            <input className="form-control" style={{ width: "320px" }} value={categoryName} onChange={(e) => setCategoryName(e.target.value)} placeholder="Tên danh mục" />
            <button className="btn btn-primary" onClick={saveCategory}>{editingCategory ? "Lưu" : "Thêm"}</button>
            {editingCategory && <button className="btn btn-outline-secondary" onClick={() => { setEditingCategory(null); setCategoryName(""); }}>Hủy</button>}
          </div>
          <div className="d-flex flex-wrap gap-2 pb-4" style={{ width: "93%" }}>
            {categories.map((item) => (
              <span className="border bg-mlight px-3 py-2 ts-smd d-inline-flex align-items-center gap-2" key={item.id}>
                {item.name}
                <button className="btn btn-sm p-0 text-main" onClick={() => { setEditingCategory(item); setCategoryName(item.name); }}><BsPencil /></button>
                <button className="btn btn-sm p-0 text-danger" onClick={() => setConfirm(item)}><BsTrash /></button>
              </span>
            ))}
          </div>
        </>
      )}

      <div className="modal fade show" style={{ display: selected ? "block" : "none", background: "rgba(0,0,0,.25)" }} tabIndex="-1">
        <div className="modal-dialog modal-lg modal-dialog-scrollable">
          <div className="modal-content">
            <div className="modal-header"><h5 className="modal-title">Chi tiết</h5><button className="btn-close" onClick={() => setSelected(null)} /></div>
            <div className="modal-body">
              {selected?.type === "user" && <pre className="bg-mlight p-3 ts-smd">{JSON.stringify(selected.data, null, 2)}</pre>}
              {selected?.type === "job" && (
                <div>
                  <h5 className="text-main">{selected.data.jname}</h5>
                  <div className="text-secondary mb-2">{selected.data.employer?.name}</div>
                  <div className="whitespace-preline">{selected.data.description || "Chưa có mô tả"}</div>
                </div>
              )}
            </div>
          </div>
        </div>
      </div>
      <div className="modal fade show" style={{ display: confirm ? "block" : "none", background: "rgba(0,0,0,.25)" }} tabIndex="-1">
        <div className="modal-dialog">
          <div className="modal-content">
            <div className="modal-header"><h5 className="modal-title">Xác nhận xóa</h5><button className="btn-close" onClick={() => setConfirm(null)} /></div>
            <div className="modal-body">Xóa danh mục "{confirm?.name}"?</div>
            <div className="modal-footer"><button className="btn btn-outline-secondary" onClick={() => setConfirm(null)}>Hủy</button><button className="btn btn-danger" onClick={deleteCategory}>Xóa</button></div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default AdminDashboard;

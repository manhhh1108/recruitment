import adminAxios from "./adminAxios";

const adminApi = {
  getDashboard: () => adminAxios.get("/admin/dashboard"),
  getUsers: (params = {}) =>
    adminAxios.get(
      `/admin/users?keyword=${params.keyword || ""}&role=${params.role || ""}`
    ),
  toggleUser: (id, is_active) =>
    adminAxios.post(`/admin/users/${id}/toggle`, { is_active }),
  getJobs: (keyword = "") => adminAxios.get(`/admin/jobs?keyword=${keyword}`),
  toggleJob: (id, is_active) =>
    adminAxios.post(`/admin/jobs/${id}/toggle`, { is_active }),
  getCategories: (type) => adminAxios.get(`/admin/categories/${type}`),
  createCategory: (type, name) =>
    adminAxios.post(`/admin/categories/${type}`, { name }),
  updateCategory: (type, id, name) =>
    adminAxios.post(`/admin/categories/${type}/${id}`, { name }),
};

export default adminApi;

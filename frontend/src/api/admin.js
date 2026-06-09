import adminAxios from "./adminAxios";

const adminApi = {
  getDashboard: () => adminAxios.get("/admin/dashboard"),
  getUsers: (params = {}) =>
    adminAxios.get(
      `/admin/users?keyword=${params.keyword || ""}&role=${params.role || ""}&is_active=${params.is_active ?? ""}&page=${params.page || 1}`
    ),
  toggleUser: (id, is_active) =>
    adminAxios.post(`/admin/users/${id}/toggle`, { is_active }),
  getJobs: (params = {}) =>
    adminAxios.get(
      `/admin/jobs?keyword=${params.keyword || ""}&is_active=${params.is_active ?? ""}&page=${params.page || 1}`
    ),
  toggleJob: (id, is_active) =>
    adminAxios.post(`/admin/jobs/${id}/toggle`, { is_active }),
  getCategories: (type) => adminAxios.get(`/admin/categories/${type}`),
  createCategory: (type, name) =>
    adminAxios.post(`/admin/categories/${type}`, { name }),
  updateCategory: (type, id, name) =>
    adminAxios.post(`/admin/categories/${type}/${id}`, { name }),
  deleteCategory: (type, id) =>
    adminAxios.delete(`/admin/categories/${type}/${id}`),
};

export default adminApi;

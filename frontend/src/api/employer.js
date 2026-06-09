import commonAxios from "./commonAxios";
import employerAxios from "./employerAxios";
import queryString from "query-string";

const prefix = "/companies";
const employerApi = {
  getList: (params) => {
    return commonAxios.get(
      `${prefix}?${queryString.stringify(params, { arrayFormat: "index" })}`
    );
  },
  getById: (id) => {
    return commonAxios.get(`${prefix}/${id}/getByID`);
  },
  getHotList: () => {
    return commonAxios.get(`${prefix}/getHotList`);
  },
  getDashboard: () => {
    return employerAxios.get(`${prefix}/dashboard`);
  },
  // destroy: (id) => {
  //   return commonAxios.delete(`${prefix}/${id}/destroy`);
  // },
  search: (keyword) => {
    return commonAxios.get(`${prefix}?keyword=${keyword}`);
  },
  getComJobs: (id) => {
    return commonAxios.get(`${prefix}/${id}/getComJobs`);
  },
  getJobList: (id, keyword = "") => {
    return commonAxios.get(`${prefix}/${id}/getJobList?keyword=${keyword || ""}`);
  },
  getCandidateList: (keyword, status, jobId = "", page = 1, perPage = 10) => {
    let url = `${prefix}/getCandidateList?keyword=${keyword || ""}&status=${status || ""}&job_id=${jobId || ""}&page=${page}&per_page=${perPage}`;
    return employerAxios.get(url);
  },
  getCandidateDetail: (jobId, candidateId) => {
    return employerAxios.get(
      `${prefix}/candidateDetail?job_id=${jobId}&candidate_id=${candidateId}`
    );
  },
  processApplying: (data) => {
    return employerAxios.post(`${prefix}/processApplying`, data);
  },
  changeJobStatus: (job_id, data) => {
    return employerAxios.post(`${prefix}/${job_id}/changeJobStatus`, data);
  },
};
export default employerApi;

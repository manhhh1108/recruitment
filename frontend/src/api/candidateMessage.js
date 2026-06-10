import candidateAxios from "./candidateAxios";

const prefix = '/cand-msgs'
const candMsgApi = {
  getMsgs: (candidateId) => {
    return candidateAxios.get(`${prefix}/${candidateId}/getByCandidateID`);
  },
  markAsRead: (msgId) => {
    return candidateAxios.get(`${prefix}/${msgId}/updateReadMsg`);
  },
  markAsUnread: (msgId) => {
    return candidateAxios.get(`${prefix}/${msgId}/updateUnreadMsg`);
  },
  unreadCount: () => {
    return candidateAxios.get(`${prefix}/unread-count`);
  },
  markAllAsRead: () => {
    return candidateAxios.post(`${prefix}/mark-all-read`);
  },
};

export default candMsgApi;

import { useEffect, useState } from "react";
import { BsCheckCircle, BsEye, BsSearch, BsXCircle } from "react-icons/bs";
import "./custom.css";
import { useForm } from "react-hook-form";
import { useSelector } from "react-redux";
import { MessagePopup } from "./popup";
import employerApi from "../../../api/employer";
import Button from "react-bootstrap/Button";
import Form from "react-bootstrap/Form";
import Modal from "react-bootstrap/Modal";
import Nav from "react-bootstrap/Nav";
import Tab from "react-bootstrap/Tab";
import clsx from "clsx";
import { toast } from "react-toastify";

function CandidateList() {
  const {
    register,
    // formState: { errors },
    handleSubmit,
  } = useForm();
  const [candidates, setCandidates] = useState([]);
  const [curCandidate, setCurCandidate] = useState({});
  const [jobOptions, setJobOptions] = useState([]);
  const [keyword, setKeyword] = useState("");
  const [status, setStatus] = useState("pending");
  const [selectedJobId, setSelectedJobId] = useState("");
  const [page, setPage] = useState(1);
  const [meta, setMeta] = useState({ current_page: 1, last_page: 1, total: 0 });
  const [step, setStep] = useState("step1");
  const [showDialog, setShowDialog] = useState(false);
  const [showDetail, setShowDetail] = useState(false);
  const [detail, setDetail] = useState({ application: {}, messages: [] });
  const [detailForm, setDetailForm] = useState({ status: "viewed", title: "", content: "" });
  const [loading, setLoading] = useState(false);
  const [selectedPosition, setSelectedPosition] = useState("");

  const isAuth = useSelector((state) => state.employerAuth.isAuth);
  const company = useSelector((state) => state.employerAuth.current.employer);

  const groupedByPosition = candidates.reduce((groups, candidate) => {
    const position = candidate.jname || "Chưa có vị trí";
    if (!groups[position]) groups[position] = [];
    groups[position].push(candidate);
    return groups;
  }, {});
  const positions = Object.keys(groupedByPosition);
  const displayedCandidates = selectedPosition
    ? groupedByPosition[selectedPosition] || []
    : candidates;
  const statusText = {
    pending: "Đã nộp",
    viewed: "Nhà tuyển dụng đã xem",
    suitable: "Phù hợp",
    rejected: "Từ chối",
    interview: "Mời phỏng vấn",
    cancelled: "Đã hủy",
    WAITING: "Đã nộp",
    BROWSING_RESUME: "Đã xem hồ sơ",
    RESUME_FAILED: "Từ chối hồ sơ",
    BROWSING_INTERVIEW: "Mời phỏng vấn",
    INTERVIEW_FAILED: "Từ chối phỏng vấn",
    PASSED: "Phù hợp",
  };

  const makeTabStyle = (tabName) => {
    return clsx(
      "fw-600 pb-1 me-5",
      step === tabName
        ? "border-2 border-bottom border-primary"
        : "text-secondary"
    );
  };
  const getCandidateList = async () => {
    setLoading(true);
    try {
      const res = await employerApi.getCandidateList(keyword, status, selectedJobId, page);
      setCandidates(res.data || res);
      setMeta({
        current_page: res.current_page || 1,
        last_page: res.last_page || 1,
        total: res.total || (res.data || res).length,
      });
    } catch (e) {
      toast.error("Không tải được danh sách ứng viên");
      setCandidates([]);
      setMeta({ current_page: 1, last_page: 1, total: 0 });
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (isAuth) getCandidateList();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [isAuth, keyword, status, selectedJobId, page]);

  useEffect(() => {
    setPage(1);
  }, [keyword, status, selectedJobId]);
  useEffect(() => {
    if (step === "step1") setStatus("pending");
    else if (step === "step2") setStatus("interview");
    else if (step === "step3") setStatus("suitable");
  }, [step]);

  const handleClickActionBtn = async (candidate, actType) => {
    if (actType === "VIEWED" && candidate.status === "pending") {
      await employerApi
        .processApplying({ ...candidate, actType })
        .then((res) => {
          console.log(res);
        });
      await getCandidateList();
    }
    if (actType !== "VIEWED") {
      setShowDialog(true);
      setCurCandidate({ ...candidate, actType, step });
    }
  };

  const openDetail = async (candidate) => {
    setShowDetail(true);
    const res = await employerApi.getCandidateDetail(candidate.job_id, candidate.candidate_id);
    setDetail(res);
    setDetailForm({ status: res.application.status, title: "", content: "" });
  };

  const updateDetailStatus = async () => {
    await employerApi.processApplying({
      ...detail.application,
      status: detailForm.status,
      title: detailForm.title || "Cập nhật trạng thái ứng tuyển",
      content: detailForm.content || "Nhà tuyển dụng đã cập nhật trạng thái hồ sơ.",
    });
    toast.success("Cập nhật trạng thái thành công");
    await openDetail(detail.application);
    await getCandidateList();
  };

  useEffect(() => {
    if (isAuth && company?.id) {
      employerApi.getJobList(company.id, "").then(setJobOptions);
    }
  }, [isAuth, company?.id]);

  useEffect(() => {
    if (selectedPosition && !groupedByPosition[selectedPosition]) {
      setSelectedPosition("");
    }
  }, [groupedByPosition, selectedPosition]);

  return (
    <>
      <div className="bg-white ms-4 mt-3" style={{ height: "90%" }}>
        <h5 className="mb-1 pt-3 text-main" style={{ marginLeft: "45px" }}>
          Danh sách ứng viên
        </h5>
        <Tab.Container onSelect={(k) => setStep(k)}>
          <Nav className="bg-mlight w-50 mx-auto pb-1 justify-content-center border">
            <Nav.Item>
              <Nav.Link eventKey="step1">
                <span className={makeTabStyle("step1")}>Duyệt hồ sơ</span>
              </Nav.Link>
            </Nav.Item>
            <Nav.Item>
              <Nav.Link eventKey="step2">
                <span className={makeTabStyle("step2")}>Mời phỏng vấn</span>
              </Nav.Link>
            </Nav.Item>
            <Nav.Item>
              <Nav.Link eventKey="step3">
                <span className={makeTabStyle("step3")}>Hoàn tất</span>
              </Nav.Link>
            </Nav.Item>
          </Nav>
        </Tab.Container>
        <div className="mt-3" style={{ marginLeft: "45px" }}>
          <div className="d-flex gap-3 mb-3 ts-smd">
            <div className="border bg-mlight px-3 py-2">
              Tổng hồ sơ: <span className="fw-600">{candidates.length}</span>
            </div>
            <div className="border bg-mlight px-3 py-2">
              Vị trí có ứng viên:{" "}
              <span className="fw-600">{positions.length}</span>
            </div>
            <div className="border bg-mlight px-3 py-2">
              Kết quả lọc: <span className="fw-600">{meta.total}</span>
            </div>
          </div>
          <Form onSubmit={handleSubmit((data) => setKeyword(data.keyword))}>
            <Form.Group className="input-group" style={{ width: "35%" }}>
              <Form.Control
                size="sm"
                type="text"
                className="border-end-0"
                placeholder="Nhập tên, email ứng viên, việc làm"
                {...register("keyword")}
              />
              <button type="submit" className="input-group-text bg-white">
                <BsSearch />
              </button>
            </Form.Group>
            {step !== "step3" && (
              <div className="d-flex flex-wrap align-items-center gap-2 mt-2 ts-smd">
                <div className="fw-500">Trạng thái: </div>&nbsp;
                <Form.Select
                  size="sm"
                  className="rounded"
                  style={{ width: "17%" }}
                  onChange={(e) => setStatus(e.target.value)}
                >
                  {step === "step1" && (
                    <>
                      <option value="pending">Chưa duyệt hồ sơ</option>
                      <option value="viewed">Đã xem hồ sơ</option>
                      <option value="rejected">Từ chối</option>
                    </>
                  )}
                  {step === "step2" && (
                    <>
                      <option value="interview">Mời phỏng vấn</option>
                      <option value="rejected">Từ chối</option>
                    </>
                  )}
                </Form.Select>
                <div className="fw-500 ms-2">Việc làm:</div>
                <Form.Select
                  size="sm"
                  className="rounded"
                  style={{ width: "30%" }}
                  value={selectedJobId}
                  onChange={(e) => setSelectedJobId(e.target.value)}
                >
                  <option value="">Tất cả việc làm</option>
                  {jobOptions.map((job) => (
                    <option value={job.id} key={job.id}>
                      {job.jname} ({job.application_count || 0})
                    </option>
                  ))}
                </Form.Select>
              </div>
            )}
          </Form>
          <div className="mt-3 pb-4" style={{ width: "90%" }}>
            {loading && (
              <div className="text-center py-4">
                <div className="spinner-border text-main" />
              </div>
            )}
            {positions.length > 0 && (
              <div className="mb-3">
                <div className="fw-600 mb-2">Vị trí ứng tuyển</div>
                <div className="d-flex flex-wrap gap-2">
                  <button
                    type="button"
                    className={clsx(
                      "btn btn-sm",
                      selectedPosition === ""
                        ? "btn-primary"
                        : "btn-outline-primary"
                    )}
                    onClick={() => setSelectedPosition("")}
                  >
                    Tất cả ({candidates.length})
                  </button>
                  {positions.map((position) => (
                    <button
                      type="button"
                      className={clsx(
                        "btn btn-sm",
                        selectedPosition === position
                          ? "btn-primary"
                          : "btn-outline-primary"
                      )}
                      key={position}
                      onClick={() => setSelectedPosition(position)}
                    >
                      {position} ({groupedByPosition[position].length})
                    </button>
                  ))}
                </div>
              </div>
            )}
            {!loading && displayedCandidates.length > 0 && (
              <div className="table-responsive">
              <table className="table table-borderless border text-center shadow-sm">
                <thead className="table-primary ts-smd">
                  <tr>
                    <th style={{ width: "17%" }}>Họ tên</th>
                    <th>Vị trí ứng tuyển</th>
                    <th style={{ width: "15%" }}>Thời gian</th>
                    <th style={{ width: "13%" }}>Trạng thái</th>
                    <th style={{ width: "12%" }}>Số điện thoại</th>
                    <th style={{ width: "16%" }}>Email</th>
                    <th style={{ width: "13%" }}>Hành động</th>
                  </tr>
                </thead>
                <tbody className="ts-sm">
                  {displayedCandidates.map((item) => (
                    <tr key={`${item.job_id}-${item.candidate_id}`}>
                      <td>
                        <button
                          type="button"
                          className="btn btn-link p-0 text-main text-decoration-none"
                          onClick={() => openDetail(item)}
                        >
                          {item.lastname + " " + item.firstname}
                        </button>
                      </td>
                      <td>{item.jname}</td>
                      <td>{item.appliedTime}</td>
                      <td>
                        <span className="badge bg-main">
                          {statusText[item.status] || item.status}
                        </span>
                      </td>
                      <td>{item.phone}</td>
                      <td>{item.email}</td>
                      <td style={{ fontSize: "17px" }}>
                        {item.status !== "suitable" &&
                        item.status !== "rejected" &&
                        item.status !== "cancelled" ? (
                          <>
                            <button
                              className="border-0 bg-white"
                              onClick={() =>
                                handleClickActionBtn(item, "ACCEPT")
                              }
                            >
                              <BsCheckCircle className="text-success" />
                            </button>
                            <button
                              className="border-0 bg-white"
                              onClick={() =>
                                handleClickActionBtn(item, "REJECT")
                              }
                            >
                              <BsXCircle className="ms-2 text-danger" />
                            </button>
                          </>
                        ) : null}
                        <a
                          className="ms-2"
                          style={{ textDecoration: "none" }}
                          href={item.cv_link}
                          target="_blank"
                          rel="noreferrer"
                        >
                          <BsEye
                            type="button"
                            className="text-primary"
                            onClick={() => handleClickActionBtn(item, "VIEWED")}
                          />
                        </a>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
              </div>
            )}
            {!loading && candidates.length === 0 && (
              <div className="border bg-mlight p-4 text-center">
                Không có ứng viên phù hợp với bộ lọc hiện tại
              </div>
            )}
            {!loading && meta.last_page > 1 && (
              <div className="d-flex gap-2 justify-content-end">
                <button
                  className="btn btn-sm btn-outline-primary"
                  disabled={meta.current_page <= 1}
                  onClick={() => setPage(meta.current_page - 1)}
                >
                  Trước
                </button>
                <span className="ts-smd py-1">
                  Trang {meta.current_page}/{meta.last_page}
                </span>
                <button
                  className="btn btn-sm btn-outline-primary"
                  disabled={meta.current_page >= meta.last_page}
                  onClick={() => setPage(meta.current_page + 1)}
                >
                  Sau
                </button>
              </div>
            )}
            <MessagePopup
              candidate={curCandidate}
              showDialog={showDialog}
              setShowDialog={setShowDialog}
              getCandidateList={getCandidateList}
            />
          </div>
        </div>
      </div>
      <Modal show={showDetail} onHide={() => setShowDetail(false)} size="lg" fullscreen="md-down">
        <Modal.Header closeButton>
          <Modal.Title>Chi tiết ứng viên</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <div className="bg-mlight p-3 mb-3">
            <div className="fw-600 text-main ts-lg">
              {detail.application.lastname} {detail.application.firstname}
            </div>
            <div>{detail.application.email} - {detail.application.phone}</div>
            <div>Vị trí: <span className="fw-600">{detail.application.jname}</span></div>
            <div>Ngày nộp: {detail.application.appliedTime}</div>
          </div>
          <div className="row g-3">
            <div className="col-md-6">
              <div className="border p-3 h-100">
                <div className="fw-600 text-main mb-2">Thông tin cá nhân</div>
                <div>Giới tính: {detail.application.gender || "Chưa cập nhật"}</div>
                <div>Ngày sinh: {detail.application.dob || "Chưa cập nhật"}</div>
                <div>Địa chỉ: {detail.application.address || "Chưa cập nhật"}</div>
                <div>Portfolio: {detail.application.link || "Chưa cập nhật"}</div>
                <div className="mt-2 whitespace-preline">{detail.application.objective}</div>
                {detail.application.cv_link && (
                  <a className="btn btn-sm btn-outline-primary mt-3" href={detail.application.cv_link} target="_blank" rel="noreferrer">
                    Xem CV
                  </a>
                )}
              </div>
            </div>
            <div className="col-md-6">
              <div className="border p-3 h-100">
                <div className="fw-600 text-main mb-2">Cập nhật trạng thái</div>
                <Form.Select size="sm" value={detailForm.status} onChange={(e) => setDetailForm({ ...detailForm, status: e.target.value })}>
                  <option value="viewed">Đã xem</option>
                  <option value="interview">Mời phỏng vấn</option>
                  <option value="suitable">Phù hợp</option>
                  <option value="rejected">Từ chối</option>
                </Form.Select>
                <Form.Control className="mt-2" size="sm" placeholder="Tiêu đề thông báo" value={detailForm.title} onChange={(e) => setDetailForm({ ...detailForm, title: e.target.value })} />
                <Form.Control className="mt-2" as="textarea" rows={4} placeholder="Ghi chú gửi ứng viên" value={detailForm.content} onChange={(e) => setDetailForm({ ...detailForm, content: e.target.value })} />
                <Button className="mt-2" size="sm" onClick={updateDetailStatus}>Cập nhật</Button>
              </div>
            </div>
          </div>
          <div className="border p-3 mt-3">
            <div className="fw-600 text-main mb-2">Lịch sử trạng thái</div>
            {detail.messages.length === 0 && <div className="text-secondary">Chưa có ghi chú</div>}
            {detail.messages.map((msg) => (
              <div className="border-bottom py-2" key={msg.id}>
                <div className="fw-600">{msg.title || msg.name}</div>
                <div className="text-secondary ts-sm">{msg.name}</div>
                <div className="whitespace-preline">{msg.content}</div>
              </div>
            ))}
          </div>
        </Modal.Body>
      </Modal>
    </>
  );
}

export default CandidateList;

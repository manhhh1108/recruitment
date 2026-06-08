# Report Improvement Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Bo sung noi dung Chuong 2 (Phan tich he thong) va Chuong 3 (Thiet ke he thong) trong bao cao do an tot nghiep .docx de phan anh dung he thong thuc te.

**Architecture:** Su dung Python voi thu vien python-docx de sua truc tiep file .docx goc. Moi task la mot Python script doc file, chen noi dung vao dung vi tri, roi ghi lai. Cac task chay tuan tu vi cung sua mot file.

**Tech Stack:** Python 3, python-docx

---

### Task 1: Bo sung danh sach chuc nang vao muc 2.1.1

**Files:**
- Modify: `K62_211213818_BuiDucTaiAnh_CNTT4.docx` (paragraph index ~409, sau dong "Chuc nang tim kiem bai viet")

- [ ] **Step 1: Tao backup file goc**

```bash
cd "D:/JobPotal/recruitment_web-xw1rpa/recruitment_web"
cp K62_211213818_BuiDucTaiAnh_CNTT4.docx K62_211213818_BuiDucTaiAnh_CNTT4_backup.docx
```

- [ ] **Step 2: Chay script bo sung chuc nang**

Tao file `scripts/task1_add_functions.py`:

```python
from docx import Document
from docx.shared import Pt
from copy import deepcopy

doc = Document('K62_211213818_BuiDucTaiAnh_CNTT4.docx')

# Tim vi tri paragraph 409 (sau "Chuc nang tim kiem bai viet")
# Them cac chuc nang moi vao danh sach List Paragraph (sau paragraph index 392)
# Va them mo ta chi tiet (sau paragraph index 409)

# --- Phan 1: Them vao danh sach List Paragraph (sau index 392 "Tim kiem bai viet") ---
new_list_items = [
    "Quản lý học vấn",
    "Quản lý kinh nghiệm làm việc",
    "Quản lý kỹ năng",
    "Quản lý dự án cá nhân",
    "Quản lý chứng chỉ",
    "Quản lý giải thưởng",
    "Quản lý hoạt động ngoại khóa",
    "Quản lý thông tin khác",
    "Quản lý CV/Resume trực tuyến",
    "Xem thông báo kết quả ứng tuyển",
]

# Find the reference paragraph (index 392 = "Tim kiem bai viet")
ref_para = doc.paragraphs[392]
ref_element = ref_para._element

for item_text in reversed(new_list_items):
    new_p = deepcopy(ref_para._element)
    # Clear runs and set new text
    for run_el in new_p.findall('.//{http://schemas.openxmlformats.org/wordprocessingml/2006/main}r'):
        new_p.remove(run_el)
    from docx.oxml.ns import qn
    run = deepcopy(ref_para._element.findall('.//{http://schemas.openxmlformats.org/wordprocessingml/2006/main}r')[0])
    for t in run.findall('.//{http://schemas.openxmlformats.org/wordprocessingml/2006/main}t'):
        t.text = item_text
    new_p.append(run)
    ref_element.addnext(new_p)

# --- Phan 2: Them mo ta chi tiet (sau index 409) ---
descriptions = [
    "Chức năng quản lý học vấn: cho phép ứng viên thêm, sửa, xóa các thông tin về quá trình học tập của mình. Mỗi mục học vấn bao gồm tên trường, chuyên ngành, thời gian học và mô tả chi tiết. Thông tin học vấn được hiển thị trên hồ sơ xin việc và giúp nhà tuyển dụng đánh giá trình độ của ứng viên.",
    "Chức năng quản lý kinh nghiệm làm việc: cho phép ứng viên thêm, sửa, xóa các kinh nghiệm làm việc. Mỗi mục kinh nghiệm bao gồm tên vị trí, tên công ty, loại hình công việc, thời gian làm việc và mô tả công việc. Đây là thông tin quan trọng giúp nhà tuyển dụng đánh giá năng lực thực tế của ứng viên.",
    "Chức năng quản lý kỹ năng: cho phép ứng viên thêm, sửa, xóa các kỹ năng cá nhân. Mỗi mục kỹ năng bao gồm tên kỹ năng và mô tả mức độ thành thạo. Kỹ năng là tiêu chí quan trọng để nhà tuyển dụng lọc và đánh giá ứng viên phù hợp với yêu cầu công việc.",
    "Chức năng quản lý dự án cá nhân: cho phép ứng viên thêm, sửa, xóa các dự án đã tham gia hoặc thực hiện. Mỗi dự án bao gồm tên dự án, thời gian thực hiện, mô tả, hình ảnh minh họa và liên kết tham khảo. Thông tin dự án giúp ứng viên thể hiện năng lực thực tế ngoài bằng cấp và kinh nghiệm làm việc.",
    "Chức năng quản lý chứng chỉ: cho phép ứng viên thêm, sửa, xóa các chứng chỉ chuyên môn đã đạt được. Mỗi chứng chỉ bao gồm tên chứng chỉ và hình ảnh minh chứng. Chứng chỉ là bằng chứng khách quan về năng lực chuyên môn, giúp hồ sơ ứng viên thêm uy tín.",
    "Chức năng quản lý giải thưởng: cho phép ứng viên thêm, sửa, xóa các giải thưởng đã đạt được trong quá trình học tập và làm việc. Mỗi giải thưởng bao gồm tên giải thưởng và hình ảnh minh chứng. Giải thưởng giúp ứng viên nổi bật hơn trong mắt nhà tuyển dụng.",
    "Chức năng quản lý hoạt động ngoại khóa: cho phép ứng viên thêm, sửa, xóa các hoạt động ngoại khóa, tình nguyện hoặc cộng đồng. Mỗi hoạt động bao gồm tên tổ chức, vai trò, thời gian tham gia, mô tả, hình ảnh và liên kết. Hoạt động ngoại khóa giúp nhà tuyển dụng đánh giá kỹ năng mềm và tính cách của ứng viên.",
    "Chức năng quản lý thông tin khác: cho phép ứng viên bổ sung các thông tin cá nhân khác ngoài các mục đã có sẵn. Mỗi mục bao gồm tên mục và mô tả chi tiết. Chức năng này mang lại sự linh hoạt cho ứng viên trong việc trình bày hồ sơ.",
    "Chức năng quản lý CV/Resume trực tuyến: cho phép ứng viên tạo mới, chỉnh sửa và xóa các CV trực tuyến trên hệ thống. Mỗi CV bao gồm thông tin cá nhân, mục tiêu nghề nghiệp, học vấn, kinh nghiệm, kỹ năng, dự án, chứng chỉ, giải thưởng và hoạt động. Ứng viên có thể tạo nhiều CV khác nhau để phù hợp với từng vị trí ứng tuyển. Hệ thống hỗ trợ tùy chỉnh thứ tự các phần trong CV và xuất CV dưới dạng hình ảnh.",
    "Chức năng xem thông báo kết quả ứng tuyển: cho phép ứng viên nhận và xem các thông báo từ hệ thống về kết quả xử lý hồ sơ ứng tuyển. Khi nhà tuyển dụng thay đổi trạng thái hồ sơ (đã xem, chấp nhận, từ chối, mời phỏng vấn), hệ thống tự động gửi thông báo cho ứng viên. Chức năng này giúp ứng viên chủ động theo dõi tiến trình ứng tuyển của mình.",
]

ref_para_desc = doc.paragraphs[409]
ref_desc_element = ref_para_desc._element

for desc_text in reversed(descriptions):
    new_p = deepcopy(ref_para_desc._element)
    for run_el in new_p.findall('.//{http://schemas.openxmlformats.org/wordprocessingml/2006/main}r'):
        new_p.remove(run_el)
    run = deepcopy(ref_para_desc._element.findall('.//{http://schemas.openxmlformats.org/wordprocessingml/2006/main}r')[0])
    for t in run.findall('.//{http://schemas.openxmlformats.org/wordprocessingml/2006/main}t'):
        t.text = desc_text
    new_p.append(run)
    ref_desc_element.addnext(new_p)

doc.save('K62_211213818_BuiDucTaiAnh_CNTT4.docx')
print("Task 1 done: Bo sung chuc nang thanh cong")
```

Run: `python scripts/task1_add_functions.py`
Expected: "Task 1 done: Bo sung chuc nang thanh cong"

- [ ] **Step 3: Commit**

```bash
git add scripts/task1_add_functions.py K62_211213818_BuiDucTaiAnh_CNTT4.docx
git commit -m "docs: add missing function descriptions to chapter 2"
```

---

### Task 2: Bo sung dac ta chuc nang nhom 3 (muc 2.2.3)

**Files:**
- Modify: `K62_211213818_BuiDucTaiAnh_CNTT4.docx` (sau muc 2.2.2.3 - paragraph ~455)

- [ ] **Step 1: Chay script bo sung dac ta chuc nang**

Tao file `scripts/task2_add_func_specs.py`:

```python
from docx import Document
from docx.shared import Pt, Cm
from docx.oxml.ns import qn
from copy import deepcopy

doc = Document('K62_211213818_BuiDucTaiAnh_CNTT4.docx')

# Tim vi tri sau bang 2.12 (Bảng cuoi cung cua muc 2.2.2)
# Chen heading "2.2.3. Chức năng quản lý hồ sơ ứng viên" va cac bang dac ta

# Tim paragraph "2.2.2.3. Cập nhật tin tuyển dụng" va bang tiep theo
# Chen sau bang 2.12 (table index 12)

# Vi tri chen: sau paragraph chua "Bảng 2.12"
insert_after = None
for i, p in enumerate(doc.paragraphs):
    if 'Bảng 2.12' in p.text:
        insert_after = p._element
        break

if insert_after is None:
    # Fallback: tim paragraph index 455
    insert_after = doc.paragraphs[455]._element

# Lay mau style tu cac heading hien co
h3_ref = doc.paragraphs[445]  # "2.2.2. Chức năng quản lý tuyển dụng" - Heading 3
h4_ref = doc.paragraphs[446]  # "2.2.2.1. Tìm kiếm nhà tuyển dụng" - Heading 4
normal_ref = doc.paragraphs[447]  # "Thong tin chung chuc nang" - Normal

# Cac chuc nang can them dac ta
func_specs = [
    {
        "heading": "2.2.3. Chức năng quản lý hồ sơ ứng viên",
        "level": 3,
        "subs": [
            {
                "heading": "2.2.3.1. Quản lý học vấn",
                "table_name": "Bảng 2.13",
                "data": [
                    ("Tên chức năng", "Quản lý học vấn"),
                    ("Tác nhân", "Ứng viên"),
                    ("Mô tả", "Cho phép ứng viên thêm, sửa, xóa thông tin học vấn bao gồm tên trường, chuyên ngành, thời gian học và mô tả chi tiết."),
                    ("Đầu vào", "Tên trường, chuyên ngành, ngày bắt đầu, ngày kết thúc, mô tả"),
                    ("Đầu ra", "Thông tin học vấn được lưu/cập nhật/xóa thành công"),
                    ("Điều kiện trước", "Ứng viên đã đăng nhập vào hệ thống"),
                    ("Điều kiện sau", "Thông tin học vấn được cập nhật trong hồ sơ ứng viên"),
                    ("Ngoại lệ", "Thiếu thông tin bắt buộc"),
                    ("Các yêu cầu đặc biệt", ""),
                ]
            },
            {
                "heading": "2.2.3.2. Quản lý kinh nghiệm làm việc",
                "table_name": "Bảng 2.14",
                "data": [
                    ("Tên chức năng", "Quản lý kinh nghiệm làm việc"),
                    ("Tác nhân", "Ứng viên"),
                    ("Mô tả", "Cho phép ứng viên thêm, sửa, xóa kinh nghiệm làm việc bao gồm tên vị trí, công ty, loại hình công việc, thời gian và mô tả."),
                    ("Đầu vào", "Tên vị trí, tên công ty, loại hình công việc, ngày bắt đầu, ngày kết thúc, mô tả"),
                    ("Đầu ra", "Thông tin kinh nghiệm được lưu/cập nhật/xóa thành công"),
                    ("Điều kiện trước", "Ứng viên đã đăng nhập vào hệ thống"),
                    ("Điều kiện sau", "Thông tin kinh nghiệm được cập nhật trong hồ sơ ứng viên"),
                    ("Ngoại lệ", "Thiếu thông tin bắt buộc"),
                    ("Các yêu cầu đặc biệt", ""),
                ]
            },
            {
                "heading": "2.2.3.3. Quản lý kỹ năng",
                "table_name": "Bảng 2.15",
                "data": [
                    ("Tên chức năng", "Quản lý kỹ năng"),
                    ("Tác nhân", "Ứng viên"),
                    ("Mô tả", "Cho phép ứng viên thêm, sửa, xóa các kỹ năng cá nhân bao gồm tên kỹ năng và mô tả mức độ thành thạo."),
                    ("Đầu vào", "Tên kỹ năng, mô tả"),
                    ("Đầu ra", "Thông tin kỹ năng được lưu/cập nhật/xóa thành công"),
                    ("Điều kiện trước", "Ứng viên đã đăng nhập vào hệ thống"),
                    ("Điều kiện sau", "Thông tin kỹ năng được cập nhật trong hồ sơ ứng viên"),
                    ("Ngoại lệ", "Thiếu thông tin bắt buộc"),
                    ("Các yêu cầu đặc biệt", ""),
                ]
            },
            {
                "heading": "2.2.3.4. Quản lý dự án cá nhân",
                "table_name": "Bảng 2.16",
                "data": [
                    ("Tên chức năng", "Quản lý dự án cá nhân"),
                    ("Tác nhân", "Ứng viên"),
                    ("Mô tả", "Cho phép ứng viên thêm, sửa, xóa các dự án đã thực hiện bao gồm tên dự án, thời gian, mô tả, hình ảnh và liên kết."),
                    ("Đầu vào", "Tên dự án, ngày bắt đầu, ngày kết thúc, mô tả, hình ảnh, liên kết"),
                    ("Đầu ra", "Thông tin dự án được lưu/cập nhật/xóa thành công"),
                    ("Điều kiện trước", "Ứng viên đã đăng nhập vào hệ thống"),
                    ("Điều kiện sau", "Thông tin dự án được cập nhật trong hồ sơ ứng viên"),
                    ("Ngoại lệ", "Thiếu thông tin bắt buộc"),
                    ("Các yêu cầu đặc biệt", ""),
                ]
            },
            {
                "heading": "2.2.3.5. Quản lý chứng chỉ",
                "table_name": "Bảng 2.17",
                "data": [
                    ("Tên chức năng", "Quản lý chứng chỉ"),
                    ("Tác nhân", "Ứng viên"),
                    ("Mô tả", "Cho phép ứng viên thêm, sửa, xóa các chứng chỉ chuyên môn bao gồm tên chứng chỉ và hình ảnh minh chứng."),
                    ("Đầu vào", "Tên chứng chỉ, hình ảnh"),
                    ("Đầu ra", "Thông tin chứng chỉ được lưu/cập nhật/xóa thành công"),
                    ("Điều kiện trước", "Ứng viên đã đăng nhập vào hệ thống"),
                    ("Điều kiện sau", "Thông tin chứng chỉ được cập nhật trong hồ sơ ứng viên"),
                    ("Ngoại lệ", "Thiếu thông tin bắt buộc"),
                    ("Các yêu cầu đặc biệt", ""),
                ]
            },
            {
                "heading": "2.2.3.6. Quản lý giải thưởng",
                "table_name": "Bảng 2.18",
                "data": [
                    ("Tên chức năng", "Quản lý giải thưởng"),
                    ("Tác nhân", "Ứng viên"),
                    ("Mô tả", "Cho phép ứng viên thêm, sửa, xóa các giải thưởng đã đạt được bao gồm tên giải thưởng và hình ảnh minh chứng."),
                    ("Đầu vào", "Tên giải thưởng, hình ảnh"),
                    ("Đầu ra", "Thông tin giải thưởng được lưu/cập nhật/xóa thành công"),
                    ("Điều kiện trước", "Ứng viên đã đăng nhập vào hệ thống"),
                    ("Điều kiện sau", "Thông tin giải thưởng được cập nhật trong hồ sơ ứng viên"),
                    ("Ngoại lệ", "Thiếu thông tin bắt buộc"),
                    ("Các yêu cầu đặc biệt", ""),
                ]
            },
            {
                "heading": "2.2.3.7. Quản lý hoạt động ngoại khóa",
                "table_name": "Bảng 2.19",
                "data": [
                    ("Tên chức năng", "Quản lý hoạt động ngoại khóa"),
                    ("Tác nhân", "Ứng viên"),
                    ("Mô tả", "Cho phép ứng viên thêm, sửa, xóa các hoạt động ngoại khóa, tình nguyện bao gồm tên tổ chức, vai trò, thời gian, mô tả, hình ảnh và liên kết."),
                    ("Đầu vào", "Tên tổ chức, vai trò, đang tham gia, ngày bắt đầu, ngày kết thúc, mô tả, hình ảnh, liên kết"),
                    ("Đầu ra", "Thông tin hoạt động được lưu/cập nhật/xóa thành công"),
                    ("Điều kiện trước", "Ứng viên đã đăng nhập vào hệ thống"),
                    ("Điều kiện sau", "Thông tin hoạt động được cập nhật trong hồ sơ ứng viên"),
                    ("Ngoại lệ", "Thiếu thông tin bắt buộc"),
                    ("Các yêu cầu đặc biệt", ""),
                ]
            },
            {
                "heading": "2.2.3.8. Quản lý CV/Resume trực tuyến",
                "table_name": "Bảng 2.20",
                "data": [
                    ("Tên chức năng", "Quản lý CV/Resume trực tuyến"),
                    ("Tác nhân", "Ứng viên"),
                    ("Mô tả", "Cho phép ứng viên tạo mới, chỉnh sửa, xóa CV trực tuyến. CV tổng hợp thông tin cá nhân, mục tiêu, học vấn, kinh nghiệm, kỹ năng, dự án, chứng chỉ, giải thưởng, hoạt động. Hỗ trợ tùy chỉnh thứ tự và xuất CV dạng hình ảnh."),
                    ("Đầu vào", "Tiêu đề CV, thông tin cá nhân, mục tiêu nghề nghiệp, các phần nội dung CV"),
                    ("Đầu ra", "CV được tạo/cập nhật/xóa thành công"),
                    ("Điều kiện trước", "Ứng viên đã đăng nhập và có thông tin cá nhân cơ bản"),
                    ("Điều kiện sau", "CV được lưu trong hệ thống, sẵn sàng để sử dụng khi ứng tuyển"),
                    ("Ngoại lệ", "Thiếu thông tin bắt buộc"),
                    ("Các yêu cầu đặc biệt", "Hỗ trợ tùy chỉnh thứ tự các phần trong CV (parts_order)"),
                ]
            },
        ]
    }
]

# Helper: chen paragraph sau mot element
def insert_paragraph_after(ref_element, text, style_name):
    new_p = deepcopy(doc.paragraphs[0]._element)  # template
    # Clear all content
    for child in list(new_p):
        new_p.remove(child)
    # Set style
    from docx.oxml import OxmlElement
    pPr = OxmlElement('w:pPr')
    pStyle = OxmlElement('w:pStyle')
    pStyle.set(qn('w:val'), style_name)
    pPr.append(pStyle)
    new_p.append(pPr)
    # Add run
    run = OxmlElement('w:r')
    t = OxmlElement('w:t')
    t.text = text
    run.append(t)
    new_p.append(run)
    ref_element.addnext(new_p)
    return new_p

# Helper: chen bang 9x2 theo format dac ta chuc nang
def insert_spec_table_after(ref_element, data, table_caption):
    from docx.oxml import OxmlElement

    # Tao caption truoc
    cap_p = OxmlElement('w:p')
    pPr = OxmlElement('w:pPr')
    pStyle = OxmlElement('w:pStyle')
    pStyle.set(qn('w:val'), 'Bảng')
    pPr.append(pStyle)
    cap_p.append(pPr)
    run = OxmlElement('w:r')
    t = OxmlElement('w:t')
    t.text = table_caption
    run.append(t)
    cap_p.append(run)

    # Lay mau table tu table hien co (table index 1)
    ref_table = doc.tables[1]._tbl
    new_tbl = deepcopy(ref_table)
    # Cap nhat noi dung tung cell
    rows = new_tbl.findall(qn('w:tr'))
    for r_idx, row in enumerate(rows):
        cells = row.findall(qn('w:tc'))
        if r_idx < len(data):
            for c_idx, cell in enumerate(cells):
                # Tim text element va cap nhat
                for p in cell.findall(qn('w:p')):
                    for run_el in p.findall(qn('w:r')):
                        for t_el in run_el.findall(qn('w:t')):
                            t_el.text = data[r_idx][c_idx]

    # Chen vao document: caption truoc, table sau
    ref_element.addnext(new_tbl)
    ref_element.addnext(cap_p)

    # Them "Thong tin chung chuc nang" paragraph
    info_p = OxmlElement('w:p')
    pPr2 = OxmlElement('w:pPr')
    pStyle2 = OxmlElement('w:pStyle')
    pStyle2.set(qn('w:val'), 'Normal')
    pPr2.append(pStyle2)
    info_p.append(pPr2)
    run2 = OxmlElement('w:r')
    t2 = OxmlElement('w:t')
    t2.text = "Thông tin chung chức năng"
    run2.append(t2)
    info_p.append(run2)

    ref_element.addnext(info_p)

    return new_tbl

# Chen noi dung - lam nguoc tu duoi len de giu dung thu tu
body = doc.element.body
current_ref = insert_after

for group in func_specs:
    # Chen heading nhom (Heading 3)
    group_h = insert_paragraph_after(current_ref, group["heading"], "Heading 3")
    current_ref = group_h

    for sub in group["subs"]:
        # Chen heading con (Heading 4)
        sub_h = insert_paragraph_after(current_ref, sub["heading"], "Heading 4")
        current_ref = sub_h
        # Chen bang dac ta
        tbl = insert_spec_table_after(current_ref, sub["data"], sub["table_name"])
        current_ref = tbl

doc.save('K62_211213818_BuiDucTaiAnh_CNTT4.docx')
print("Task 2 done: Bo sung dac ta chuc nang nhom 3")
```

Run: `python scripts/task2_add_func_specs.py`
Expected: "Task 2 done: Bo sung dac ta chuc nang nhom 3"

- [ ] **Step 2: Commit**

```bash
git add scripts/task2_add_func_specs.py K62_211213818_BuiDucTaiAnh_CNTT4.docx
git commit -m "docs: add function spec group 3 - candidate profile management"
```

---

### Task 3: Them muc Use Case Diagram (muc 2.4)

**Files:**
- Modify: `K62_211213818_BuiDucTaiAnh_CNTT4.docx` (chen sau muc 2.3 - sau DFD cuoi cung)

- [ ] **Step 1: Chay script them Use Case**

Tao file `scripts/task3_add_usecase.py`:

```python
from docx import Document
from docx.shared import Pt, Cm, Inches
from docx.oxml.ns import qn
from docx.oxml import OxmlElement
from copy import deepcopy

doc = Document('K62_211213818_BuiDucTaiAnh_CNTT4.docx')

# Tim vi tri chen: sau paragraph cuoi cua muc 2.3
# (sau "Hinh 2.5: So do luong du lieu muc duoi dinh-quan ly tuyen dung")
insert_after = None
for i, p in enumerate(doc.paragraphs):
    if 'Hình 2.5' in p.text and 'mức dưới đỉnh' in p.text:
        insert_after = p._element
        break

if insert_after is None:
    insert_after = doc.paragraphs[481]._element

def add_paragraph_after(ref, text, style_name):
    new_p = OxmlElement('w:p')
    pPr = OxmlElement('w:pPr')
    pStyle = OxmlElement('w:pStyle')
    pStyle.set(qn('w:val'), style_name)
    pPr.append(pStyle)
    new_p.append(pPr)
    run = OxmlElement('w:r')
    t = OxmlElement('w:t')
    t.text = text
    t.set(qn('xml:space'), 'preserve')
    run.append(t)
    new_p.append(run)
    ref.addnext(new_p)
    return new_p

def add_table_after(ref, headers, rows_data):
    """Tao bang don gian"""
    from docx.oxml import OxmlElement

    tbl = OxmlElement('w:tbl')
    # Table properties
    tblPr = OxmlElement('w:tblPr')
    tblStyle = OxmlElement('w:tblStyle')
    tblStyle.set(qn('w:val'), 'TableGrid')
    tblPr.append(tblStyle)
    tblW = OxmlElement('w:tblW')
    tblW.set(qn('w:w'), '5000')
    tblW.set(qn('w:type'), 'pct')
    tblPr.append(tblW)
    tbl.append(tblPr)
    # Table grid
    tblGrid = OxmlElement('w:tblGrid')
    for _ in headers:
        gridCol = OxmlElement('w:gridCol')
        gridCol.set(qn('w:w'), str(9000 // len(headers)))
        tblGrid.append(gridCol)
    tbl.append(tblGrid)

    def make_row(cells_text, bold=False):
        tr = OxmlElement('w:tr')
        for cell_text in cells_text:
            tc = OxmlElement('w:tc')
            p = OxmlElement('w:p')
            r = OxmlElement('w:r')
            if bold:
                rPr = OxmlElement('w:rPr')
                b = OxmlElement('w:b')
                rPr.append(b)
                r.append(rPr)
            t = OxmlElement('w:t')
            t.text = cell_text
            t.set(qn('xml:space'), 'preserve')
            r.append(t)
            p.append(r)
            tc.append(p)
            tr.append(tc)
        return tr

    tbl.append(make_row(headers, bold=True))
    for row in rows_data:
        tbl.append(make_row(row))

    ref.addnext(tbl)
    return tbl

# === Chen noi dung Use Case ===
cur = insert_after

# Heading 2
cur = add_paragraph_after(cur, "2.4. Biểu đồ ca sử dụng (Use Case Diagram)", "Heading 2")

# Mo ta tong quan
cur = add_paragraph_after(cur, "Biểu đồ ca sử dụng (Use Case Diagram) mô tả các chức năng mà hệ thống cung cấp cho từng loại người dùng. Hệ thống website tuyển dụng có hai tác nhân chính: Ứng viên và Nhà tuyển dụng. Mỗi tác nhân có các ca sử dụng tương ứng với vai trò và quyền hạn của mình trong hệ thống.", "Normal")

# Heading 3: Xac dinh actor
cur = add_paragraph_after(cur, "2.4.1. Xác định tác nhân (Actor)", "Heading 3")

cur = add_paragraph_after(cur, "Hệ thống có hai tác nhân chính tương tác trực tiếp với hệ thống:", "Normal")

# Bang actor
actor_headers = ["STT", "Tác nhân", "Mô tả"]
actor_rows = [
    ["1", "Ứng viên (Candidate)", "Người tìm việc sử dụng hệ thống để đăng ký, tạo hồ sơ, tìm kiếm việc làm, ứng tuyển và quản lý thông tin cá nhân."],
    ["2", "Nhà tuyển dụng (Employer)", "Doanh nghiệp sử dụng hệ thống để đăng tin tuyển dụng, quản lý danh sách ứng viên, xem hồ sơ và xử lý đơn ứng tuyển."],
]
tbl1 = add_table_after(cur, actor_headers, actor_rows)
cur = tbl1

# Caption
cur = add_paragraph_after(cur, "Bảng 2.21: Danh sách tác nhân hệ thống", "Bảng")

# Heading 3: Danh sach use case
cur = add_paragraph_after(cur, "2.4.2. Danh sách ca sử dụng", "Heading 3")

# Bang use case ung vien
cur = add_paragraph_after(cur, "Danh sách ca sử dụng của tác nhân Ứng viên:", "Normal")

uc_cand_headers = ["Mã UC", "Tên ca sử dụng", "Mô tả ngắn"]
uc_cand_rows = [
    ["UC01", "Đăng ký tài khoản", "Tạo tài khoản ứng viên mới với email và mật khẩu"],
    ["UC02", "Đăng nhập", "Xác thực người dùng bằng email, mật khẩu và nhận JWT token"],
    ["UC03", "Đăng xuất", "Kết thúc phiên làm việc, xóa thông tin xác thực"],
    ["UC04", "Cập nhật tài khoản", "Thay đổi email, mật khẩu"],
    ["UC05", "Cập nhật thông tin cá nhân", "Cập nhật họ tên, ngày sinh, giới tính, SĐT, địa chỉ, ảnh đại diện, mục tiêu"],
    ["UC06", "Quản lý học vấn", "Thêm, sửa, xóa thông tin học vấn (trường, chuyên ngành, thời gian)"],
    ["UC07", "Quản lý kinh nghiệm", "Thêm, sửa, xóa kinh nghiệm làm việc (vị trí, công ty, thời gian)"],
    ["UC08", "Quản lý kỹ năng", "Thêm, sửa, xóa kỹ năng cá nhân"],
    ["UC09", "Quản lý dự án", "Thêm, sửa, xóa dự án đã thực hiện"],
    ["UC10", "Quản lý chứng chỉ", "Thêm, sửa, xóa chứng chỉ chuyên môn"],
    ["UC11", "Quản lý giải thưởng", "Thêm, sửa, xóa giải thưởng đã đạt"],
    ["UC12", "Quản lý hoạt động", "Thêm, sửa, xóa hoạt động ngoại khóa"],
    ["UC13", "Quản lý thông tin khác", "Thêm, sửa, xóa thông tin bổ sung"],
    ["UC14", "Tạo/sửa/xóa CV trực tuyến", "Quản lý CV với đầy đủ thông tin từ hồ sơ cá nhân"],
    ["UC15", "Tìm kiếm việc làm", "Tìm kiếm theo từ khóa, ngành nghề, địa điểm, loại hình, cấp bậc"],
    ["UC16", "Lưu tin tuyển dụng", "Đánh dấu và quản lý danh sách tin tuyển dụng quan tâm"],
    ["UC17", "Ứng tuyển và nộp hồ sơ", "Nộp CV/hồ sơ vào vị trí tuyển dụng"],
    ["UC18", "Xem thông báo kết quả", "Nhận và xem thông báo xử lý hồ sơ từ nhà tuyển dụng"],
]
tbl2 = add_table_after(cur, uc_cand_headers, uc_cand_rows)
cur = tbl2
cur = add_paragraph_after(cur, "Bảng 2.22: Danh sách ca sử dụng của Ứng viên", "Bảng")

# Bang use case nha tuyen dung
cur = add_paragraph_after(cur, "Danh sách ca sử dụng của tác nhân Nhà tuyển dụng:", "Normal")

uc_emp_headers = ["Mã UC", "Tên ca sử dụng", "Mô tả ngắn"]
uc_emp_rows = [
    ["UC19", "Đăng nhập", "Xác thực nhà tuyển dụng bằng email, mật khẩu"],
    ["UC20", "Đăng xuất", "Kết thúc phiên làm việc"],
    ["UC21", "Cập nhật thông tin công ty", "Cập nhật tên, địa chỉ, quy mô, liên hệ, mô tả, logo, ảnh bìa, website"],
    ["UC22", "Tạo tin tuyển dụng", "Đăng tin mới với thông tin vị trí, yêu cầu, mức lương, ngành nghề, địa điểm"],
    ["UC23", "Cập nhật tin tuyển dụng", "Sửa thông tin và thay đổi trạng thái tin (bật/tắt)"],
    ["UC24", "Xem danh sách ứng viên", "Xem danh sách ứng viên đã ứng tuyển vào các tin"],
    ["UC25", "Xử lý hồ sơ ứng tuyển", "Xem CV, chấp nhận, từ chối hoặc mời phỏng vấn ứng viên"],
]
tbl3 = add_table_after(cur, uc_emp_headers, uc_emp_rows)
cur = tbl3
cur = add_paragraph_after(cur, "Bảng 2.23: Danh sách ca sử dụng của Nhà tuyển dụng", "Bảng")

# Mo ta Use Case Diagram
cur = add_paragraph_after(cur, "2.4.3. Biểu đồ ca sử dụng tổng quát", "Heading 3")

cur = add_paragraph_after(cur, "Biểu đồ ca sử dụng tổng quát mô tả tổng quan các chức năng mà hệ thống cung cấp cho hai tác nhân. Ứng viên có thể thực hiện các ca sử dụng từ UC01 đến UC18, bao gồm đăng ký, quản lý hồ sơ cá nhân, tạo CV, tìm kiếm việc làm và ứng tuyển. Nhà tuyển dụng có thể thực hiện các ca sử dụng từ UC19 đến UC25, bao gồm quản lý thông tin công ty, đăng tin tuyển dụng và xử lý hồ sơ ứng viên. Hai tác nhân chia sẻ chung các ca sử dụng đăng nhập và đăng xuất.", "Normal")

cur = add_paragraph_after(cur, "(Chèn biểu đồ Use Case tổng quát tại đây)", "hinh")
cur = add_paragraph_after(cur, "Hình 2.6: Biểu đồ ca sử dụng tổng quát của hệ thống", "hinh")

doc.save('K62_211213818_BuiDucTaiAnh_CNTT4.docx')
print("Task 3 done: Them Use Case Diagram")
```

Run: `python scripts/task3_add_usecase.py`
Expected: "Task 3 done: Them Use Case Diagram"

- [ ] **Step 2: Commit**

```bash
git add scripts/task3_add_usecase.py K62_211213818_BuiDucTaiAnh_CNTT4.docx
git commit -m "docs: add use case diagram section to chapter 2"
```

---

### Task 4: Them 4 Sequence Diagram (muc 2.5)

**Files:**
- Modify: `K62_211213818_BuiDucTaiAnh_CNTT4.docx` (chen sau muc 2.4 vua tao)

- [ ] **Step 1: Chay script them Sequence Diagram**

Tao file `scripts/task4_add_sequence.py`:

```python
from docx import Document
from docx.oxml.ns import qn
from docx.oxml import OxmlElement

doc = Document('K62_211213818_BuiDucTaiAnh_CNTT4.docx')

# Tim vi tri chen: sau "Hinh 2.6: Bieu do ca su dung tong quat"
insert_after = None
for i, p in enumerate(doc.paragraphs):
    if 'Hình 2.6' in p.text and 'ca sử dụng' in p.text:
        insert_after = p._element
        break

if insert_after is None:
    # Fallback: tim CHUONG 3 va chen truoc no
    for i, p in enumerate(doc.paragraphs):
        if p.text.strip() == 'CHƯƠNG 3: THIẾT KẾ HỆ THỐNG':
            insert_after = doc.paragraphs[i-1]._element
            break

def add_p(ref, text, style):
    new_p = OxmlElement('w:p')
    pPr = OxmlElement('w:pPr')
    pStyle = OxmlElement('w:pStyle')
    pStyle.set(qn('w:val'), style)
    pPr.append(pStyle)
    new_p.append(pPr)
    run = OxmlElement('w:r')
    t = OxmlElement('w:t')
    t.text = text
    t.set(qn('xml:space'), 'preserve')
    run.append(t)
    new_p.append(run)
    ref.addnext(new_p)
    return new_p

def add_table(ref, headers, rows):
    tbl = OxmlElement('w:tbl')
    tblPr = OxmlElement('w:tblPr')
    tblStyle = OxmlElement('w:tblStyle')
    tblStyle.set(qn('w:val'), 'TableGrid')
    tblPr.append(tblStyle)
    tblW = OxmlElement('w:tblW')
    tblW.set(qn('w:w'), '5000')
    tblW.set(qn('w:type'), 'pct')
    tblPr.append(tblW)
    tbl.append(tblPr)
    tblGrid = OxmlElement('w:tblGrid')
    for _ in headers:
        gridCol = OxmlElement('w:gridCol')
        gridCol.set(qn('w:w'), str(9000 // len(headers)))
        tblGrid.append(gridCol)
    tbl.append(tblGrid)
    def make_row(cells, bold=False):
        tr = OxmlElement('w:tr')
        for c in cells:
            tc = OxmlElement('w:tc')
            p = OxmlElement('w:p')
            r = OxmlElement('w:r')
            if bold:
                rPr = OxmlElement('w:rPr')
                b = OxmlElement('w:b')
                rPr.append(b)
                r.append(rPr)
            t_el = OxmlElement('w:t')
            t_el.text = c
            t_el.set(qn('xml:space'), 'preserve')
            r.append(t_el)
            p.append(r)
            tc.append(p)
            tr.append(tc)
        return tr
    tbl.append(make_row(headers, True))
    for row in rows:
        tbl.append(make_row(row))
    ref.addnext(tbl)
    return tbl

cur = insert_after

# === Heading 2 ===
cur = add_p(cur, "2.5. Biểu đồ tuần tự (Sequence Diagram)", "Heading 2")
cur = add_p(cur, "Biểu đồ tuần tự mô tả chi tiết thứ tự tương tác giữa các đối tượng trong hệ thống khi thực hiện một ca sử dụng cụ thể. Dưới đây là biểu đồ tuần tự cho bốn luồng nghiệp vụ chính của hệ thống.", "Normal")

# === SD1: Dang ky + Dang nhap ===
cur = add_p(cur, "2.5.1. Biểu đồ tuần tự: Đăng ký và Đăng nhập", "Heading 3")
cur = add_p(cur, "Biểu đồ tuần tự sau mô tả luồng xử lý khi người dùng thực hiện đăng ký tài khoản mới và đăng nhập vào hệ thống. Hệ thống sử dụng cơ chế xác thực JWT (JSON Web Token) để quản lý phiên đăng nhập.", "Normal")

sd1_headers = ["Bước", "Đối tượng gửi", "Đối tượng nhận", "Thông điệp", "Mô tả"]
sd1_rows = [
    ["1", "Ứng viên", "React UI", "Nhập thông tin đăng ký", "Nhập email, mật khẩu, họ tên"],
    ["2", "React UI", "Axios", "Gửi request", "Tạo HTTP POST request"],
    ["3", "Axios", "AuthController", "POST /api/register", "Gửi dữ liệu đăng ký lên server"],
    ["4", "AuthController", "User Model", "create()", "Tạo bản ghi user mới trong DB"],
    ["5", "AuthController", "Candidate Model", "create()", "Tạo bản ghi candidate liên kết với user"],
    ["6", "AuthController", "Axios", "Response 201", "Trả về thông tin tài khoản đã tạo"],
    ["7", "Axios", "React UI", "Hiển thị kết quả", "Thông báo đăng ký thành công"],
    ["8", "Ứng viên", "React UI", "Nhập email, mật khẩu", "Nhập thông tin đăng nhập"],
    ["9", "React UI", "Axios", "Gửi request", "Tạo HTTP POST request"],
    ["10", "Axios", "AuthController", "POST /api/login", "Gửi thông tin đăng nhập"],
    ["11", "AuthController", "JWT", "attempt(credentials)", "Xác thực thông tin và tạo JWT token"],
    ["12", "AuthController", "Axios", "Response 200 + JWT Token", "Trả về token xác thực"],
    ["13", "Axios", "Redux Store", "Lưu token", "Lưu JWT token vào state"],
    ["14", "React UI", "Ứng viên", "Chuyển trang chủ", "Đăng nhập thành công"],
]
tbl1 = add_table(cur, sd1_headers, sd1_rows)
cur = tbl1
cur = add_p(cur, "Bảng 2.24: Mô tả biểu đồ tuần tự Đăng ký và Đăng nhập", "Bảng")
cur = add_p(cur, "(Chèn biểu đồ tuần tự Đăng ký và Đăng nhập tại đây)", "hinh")
cur = add_p(cur, "Hình 2.7: Biểu đồ tuần tự Đăng ký và Đăng nhập", "hinh")

# === SD2: Tim kiem viec lam + Ung tuyen ===
cur = add_p(cur, "2.5.2. Biểu đồ tuần tự: Tìm kiếm việc làm và Ứng tuyển", "Heading 3")
cur = add_p(cur, "Biểu đồ tuần tự sau mô tả luồng xử lý khi ứng viên tìm kiếm việc làm theo các tiêu chí và thực hiện ứng tuyển vào một vị trí bằng cách nộp CV/hồ sơ.", "Normal")

sd2_headers = ["Bước", "Đối tượng gửi", "Đối tượng nhận", "Thông điệp", "Mô tả"]
sd2_rows = [
    ["1", "Ứng viên", "React UI", "Nhập tiêu chí tìm kiếm", "Nhập từ khóa, chọn ngành nghề, địa điểm, loại hình, cấp bậc"],
    ["2", "React UI", "Axios", "Gửi request", "Tạo HTTP GET request với query params"],
    ["3", "Axios", "JobController", "GET /api/jobs?keyword=...", "Gửi yêu cầu tìm kiếm"],
    ["4", "JobController", "Job Model", "search()", "Truy vấn DB với các điều kiện lọc, join job_industry, job_location"],
    ["5", "Job Model", "Database", "SELECT query", "Thực hiện truy vấn SQL"],
    ["6", "Database", "JobController", "Kết quả truy vấn", "Trả về danh sách việc làm phù hợp"],
    ["7", "JobController", "Axios", "Response 200 + JSON", "Trả về danh sách việc làm phân trang"],
    ["8", "Axios", "React UI", "Hiển thị danh sách", "Render danh sách việc làm"],
    ["9", "Ứng viên", "React UI", "Chọn việc làm + Ứng tuyển", "Nhấn nút ứng tuyển, chọn CV hoặc upload"],
    ["10", "React UI", "Axios", "Gửi request", "Tạo HTTP POST request với FormData (CV)"],
    ["11", "Axios", "JWT Middleware", "POST /api/jobs/{id}/apply", "Gửi yêu cầu ứng tuyển kèm token"],
    ["12", "JWT Middleware", "JobController", "Forward request", "Xác thực token thành công, chuyển tiếp"],
    ["13", "JobController", "job_applying", "insert()", "Tạo bản ghi ứng tuyển với status=0, lưu cv_link"],
    ["14", "JobController", "CandidateMessage", "create()", "Tạo thông báo cho ứng viên"],
    ["15", "JobController", "Axios", "Response 200", "Trả về kết quả ứng tuyển thành công"],
    ["16", "React UI", "Ứng viên", "Thông báo thành công", "Hiển thị thông báo ứng tuyển thành công"],
]
tbl2 = add_table(cur, sd2_headers, sd2_rows)
cur = tbl2
cur = add_p(cur, "Bảng 2.25: Mô tả biểu đồ tuần tự Tìm kiếm việc làm và Ứng tuyển", "Bảng")
cur = add_p(cur, "(Chèn biểu đồ tuần tự Tìm kiếm việc làm và Ứng tuyển tại đây)", "hinh")
cur = add_p(cur, "Hình 2.8: Biểu đồ tuần tự Tìm kiếm việc làm và Ứng tuyển", "hinh")

# === SD3: NTD dang tin + xu ly ho so ===
cur = add_p(cur, "2.5.3. Biểu đồ tuần tự: Đăng tin tuyển dụng và Xử lý hồ sơ", "Heading 3")
cur = add_p(cur, "Biểu đồ tuần tự sau mô tả luồng xử lý khi nhà tuyển dụng tạo tin tuyển dụng mới và xử lý các hồ sơ ứng viên đã nộp đơn.", "Normal")

sd3_headers = ["Bước", "Đối tượng gửi", "Đối tượng nhận", "Thông điệp", "Mô tả"]
sd3_rows = [
    ["1", "Nhà tuyển dụng", "React UI", "Nhập thông tin tin tuyển dụng", "Nhập tên, mô tả, yêu cầu, lương, chọn ngành, địa điểm, kỹ năng"],
    ["2", "React UI", "Axios", "Gửi request", "Tạo HTTP POST request"],
    ["3", "Axios", "JobController", "POST /api/jobs", "Gửi dữ liệu tin tuyển dụng"],
    ["4", "JobController", "Job Model", "create()", "Tạo bản ghi tin tuyển dụng"],
    ["5", "JobController", "job_industry", "attach()", "Liên kết tin với các ngành nghề"],
    ["6", "JobController", "job_location", "attach()", "Liên kết tin với các địa điểm"],
    ["7", "JobController", "job_skill", "attach()", "Liên kết tin với các kỹ năng yêu cầu"],
    ["8", "JobController", "Axios", "Response 201", "Trả về tin tuyển dụng đã tạo"],
    ["9", "React UI", "Nhà tuyển dụng", "Thông báo thành công", "Hiển thị tin tuyển dụng mới"],
    ["10", "Nhà tuyển dụng", "React UI", "Xem danh sách ứng viên", "Truy cập trang quản lý ứng viên"],
    ["11", "React UI", "Axios", "Gửi request", "Tạo HTTP GET request"],
    ["12", "Axios", "EmployerController", "GET /api/companies/getCandidateList", "Gửi yêu cầu lấy DS ứng viên"],
    ["13", "EmployerController", "job_applying", "query()", "Truy vấn DS ứng viên đã ứng tuyển"],
    ["14", "EmployerController", "Axios", "Response 200", "Trả về DS ứng viên + trạng thái hồ sơ"],
    ["15", "Nhà tuyển dụng", "React UI", "Xử lý hồ sơ ứng viên", "Chấp nhận/từ chối/mời phỏng vấn"],
    ["16", "React UI", "Axios", "Gửi request", "Tạo HTTP POST request"],
    ["17", "Axios", "EmployerController", "POST /api/companies/processApplying", "Gửi yêu cầu cập nhật trạng thái"],
    ["18", "EmployerController", "job_applying", "update(status)", "Cập nhật trạng thái hồ sơ"],
    ["19", "EmployerController", "CandidateMessage", "create()", "Tạo thông báo kết quả cho ứng viên"],
    ["20", "EmployerController", "Axios", "Response 200", "Trả về kết quả xử lý"],
]
tbl3 = add_table(cur, sd3_headers, sd3_rows)
cur = tbl3
cur = add_p(cur, "Bảng 2.26: Mô tả biểu đồ tuần tự Đăng tin tuyển dụng và Xử lý hồ sơ", "Bảng")
cur = add_p(cur, "(Chèn biểu đồ tuần tự Đăng tin tuyển dụng và Xử lý hồ sơ tại đây)", "hinh")
cur = add_p(cur, "Hình 2.9: Biểu đồ tuần tự Đăng tin tuyển dụng và Xử lý hồ sơ", "hinh")

# === SD4: Tao va quan ly CV ===
cur = add_p(cur, "2.5.4. Biểu đồ tuần tự: Tạo và quản lý CV/Resume trực tuyến", "Heading 3")
cur = add_p(cur, "Biểu đồ tuần tự sau mô tả luồng xử lý khi ứng viên tạo CV trực tuyến và bổ sung các thông tin chi tiết (học vấn, kinh nghiệm, kỹ năng, dự án, chứng chỉ, giải thưởng, hoạt động) vào CV.", "Normal")

sd4_headers = ["Bước", "Đối tượng gửi", "Đối tượng nhận", "Thông điệp", "Mô tả"]
sd4_rows = [
    ["1", "Ứng viên", "React UI", "Tạo CV mới", "Nhập tiêu đề CV, thông tin cá nhân, mục tiêu nghề nghiệp"],
    ["2", "React UI", "Axios", "Gửi request", "Tạo HTTP POST request"],
    ["3", "Axios", "ResumeController", "POST /api/resumes", "Gửi dữ liệu CV mới"],
    ["4", "ResumeController", "Resume Model", "create()", "Tạo bản ghi resume trong DB"],
    ["5", "ResumeController", "Axios", "Response 201 + resume_id", "Trả về CV đã tạo với ID"],
    ["6", "React UI", "Ứng viên", "Hiển thị form CV", "Mở form chỉnh sửa CV với các phần"],
    ["7", "Ứng viên", "React UI", "Thêm học vấn", "Nhập tên trường, chuyên ngành, thời gian"],
    ["8", "React UI", "Axios", "Gửi request", "Tạo HTTP POST request"],
    ["9", "Axios", "EducationController", "POST /api/educations", "Gửi thông tin học vấn + resume_id"],
    ["10", "EducationController", "Education Model", "create()", "Tạo bản ghi education"],
    ["11", "EducationController", "Axios", "Response 201", "Trả về học vấn đã thêm"],
    ["12", "Ứng viên", "React UI", "Thêm kinh nghiệm", "Nhập vị trí, công ty, thời gian, mô tả"],
    ["13", "React UI", "ExperienceController", "POST /api/experiences", "Gửi thông tin kinh nghiệm (qua Axios)"],
    ["14", "ExperienceController", "Experience Model", "create()", "Tạo bản ghi experience"],
    ["15", "Ứng viên", "React UI", "Thêm kỹ năng, dự án, chứng chỉ...", "Tương tự, gọi API tương ứng cho mỗi phần"],
    ["16", "React UI", "Controllers tương ứng", "POST /api/{resource}", "SkillController, ProjectController, CertificateController, PrizeController, ActivityController"],
    ["17", "Ứng viên", "React UI", "Cập nhật thứ tự phần", "Kéo thả để sắp xếp thứ tự các phần trong CV"],
    ["18", "React UI", "ResumeController", "POST /api/resumes/update", "Gửi parts_order mới (qua Axios)"],
    ["19", "ResumeController", "Resume Model", "update(parts_order)", "Cập nhật thứ tự phần"],
    ["20", "React UI", "Ứng viên", "Hiển thị CV hoàn chỉnh", "Render CV với đầy đủ thông tin"],
]
tbl4 = add_table(cur, sd4_headers, sd4_rows)
cur = tbl4
cur = add_p(cur, "Bảng 2.27: Mô tả biểu đồ tuần tự Tạo và quản lý CV/Resume", "Bảng")
cur = add_p(cur, "(Chèn biểu đồ tuần tự Tạo và quản lý CV/Resume tại đây)", "hinh")
cur = add_p(cur, "Hình 2.10: Biểu đồ tuần tự Tạo và quản lý CV/Resume trực tuyến", "hinh")

doc.save('K62_211213818_BuiDucTaiAnh_CNTT4.docx')
print("Task 4 done: Them 4 Sequence Diagram")
```

Run: `python scripts/task4_add_sequence.py`
Expected: "Task 4 done: Them 4 Sequence Diagram"

- [ ] **Step 2: Commit**

```bash
git add scripts/task4_add_sequence.py K62_211213818_BuiDucTaiAnh_CNTT4.docx
git commit -m "docs: add 4 sequence diagrams to chapter 2"
```

---

### Task 5: Sua loi danh so hinh + Bo sung thuc the CSDL Chuong 3

**Files:**
- Modify: `K62_211213818_BuiDucTaiAnh_CNTT4.docx` (Chuong 3, muc 3.2.1)

- [ ] **Step 1: Chay script sua Chuong 3**

Tao file `scripts/task5_fix_ch3_entities.py`:

```python
from docx import Document
from docx.oxml.ns import qn
from docx.oxml import OxmlElement

doc = Document('K62_211213818_BuiDucTaiAnh_CNTT4.docx')

# === Sua loi danh so hinh: "Hinh 2.6" -> "Hinh 3.1" ===
for p in doc.paragraphs:
    if 'Hình 2.6' in p.text:
        for run in p.runs:
            if 'Hình 2.6' in run.text:
                run.text = run.text.replace('Hình 2.6', 'Hình 3.1')

# === Bo sung thuc the CSDL (sau paragraph "Tin tuyen dung (Ma tin tuyen dung,...)") ===
insert_after = None
for i, p in enumerate(doc.paragraphs):
    if p.text.strip().startswith('Tin tuyển dụng (Mã tin tuyển dụng'):
        insert_after = p._element
        break

if insert_after is None:
    for i, p in enumerate(doc.paragraphs):
        if p.text.strip().startswith('Tin tuyển dụng') and 'Mã tin' in p.text:
            insert_after = p._element
            break

def add_p(ref, text, style):
    new_p = OxmlElement('w:p')
    pPr = OxmlElement('w:pPr')
    pStyle = OxmlElement('w:pStyle')
    pStyle.set(qn('w:val'), style)
    pPr.append(pStyle)
    new_p.append(pPr)
    run = OxmlElement('w:r')
    t = OxmlElement('w:t')
    t.text = text
    t.set(qn('xml:space'), 'preserve')
    run.append(t)
    new_p.append(run)
    ref.addnext(new_p)
    return new_p

cur = insert_after

# Them cac thuc the con thieu - phan xac dinh thuc the va thuoc tinh
new_entities_raw = [
    ("Học vấn", "mã ứng viên, tên trường, chuyên ngành, ngày bắt đầu, ngày kết thúc, mô tả"),
    ("Kinh nghiệm làm việc", "mã ứng viên, mã loại công việc, tên vị trí, tên công ty, ngày bắt đầu, ngày kết thúc, mô tả"),
    ("Kỹ năng ứng viên", "mã ứng viên, tên kỹ năng, mô tả"),
    ("Dự án cá nhân", "mã ứng viên, tên dự án, ngày bắt đầu, ngày kết thúc, mô tả, hình ảnh, liên kết"),
    ("Chứng chỉ", "mã ứng viên, tên chứng chỉ, hình ảnh"),
    ("Giải thưởng", "mã ứng viên, tên giải thưởng, hình ảnh"),
    ("Hoạt động ngoại khóa", "mã ứng viên, tên tổ chức, vai trò, đang tham gia, ngày bắt đầu, ngày kết thúc, mô tả, hình ảnh, liên kết"),
    ("Thông tin khác", "mã ứng viên, tên mục, mô tả"),
    ("Ngành nghề", "tên ngành nghề"),
    ("Cấp bậc", "tên cấp bậc"),
    ("Loại hình công việc", "tên loại hình"),
    ("Địa điểm", "tên địa điểm"),
    ("Hồ sơ CV", "mã ứng viên, tiêu đề, họ tên, giới tính, ngày sinh, số điện thoại, email, địa chỉ, liên kết, ảnh đại diện, mục tiêu nghề nghiệp, tiêu đề các phần, liên kết CV, thứ tự các phần"),
    ("Tin nhắn thông báo", "mã ứng viên, mã tin tuyển dụng, nội dung, trạng thái đã đọc"),
]

# Them moi thuc the
for name, attrs in reversed(new_entities_raw):
    cur = add_p(insert_after, f"{name}: {attrs}.", "Normal")

# Them heading giai thich
cur = add_p(insert_after, "Ngoài các thực thể đã nêu ở trên, hệ thống còn có các thực thể bổ sung sau đây phục vụ việc quản lý hồ sơ ứng viên, danh mục hệ thống và thông báo:", "Normal")

# === Bo sung phan xac dinh khoa cho cac thuc the moi ===
# Tim vi tri sau dong cuoi cung cua muc 3.2.1.2
insert_after_key = None
for i, p in enumerate(doc.paragraphs):
    if p.text.strip().startswith('Tin tuyển dụng (Mã tin tuyển dụng') and 'trạng thái' in p.text:
        insert_after_key = p._element
        break

if insert_after_key:
    new_entities_keyed = [
        "Xét Học vấn (mã ứng viên, tên trường, chuyên ngành, ngày bắt đầu, ngày kết thúc, mô tả). Học vấn là thực thể yếu, phụ thuộc vào Ứng viên → Khóa: (mã ứng viên, tên trường, chuyên ngành)",
        "Học vấn (mã ứng viên, tên trường, chuyên ngành, ngày bắt đầu, ngày kết thúc, mô tả)",
        "Xét Kinh nghiệm làm việc (mã ứng viên, mã loại công việc, tên vị trí, tên công ty, ngày bắt đầu, ngày kết thúc, mô tả). Kinh nghiệm là thực thể yếu → Khóa: (mã ứng viên, tên vị trí, tên công ty)",
        "Kinh nghiệm làm việc (mã ứng viên, mã loại công việc, tên vị trí, tên công ty, ngày bắt đầu, ngày kết thúc, mô tả)",
        "Xét Kỹ năng ứng viên (mã ứng viên, tên kỹ năng, mô tả). Kỹ năng là thực thể yếu → Khóa: (mã ứng viên, tên kỹ năng)",
        "Kỹ năng ứng viên (mã ứng viên, tên kỹ năng, mô tả)",
        "Xét Dự án cá nhân (mã ứng viên, tên dự án, ngày bắt đầu, ngày kết thúc, mô tả, hình ảnh, liên kết). Dự án là thực thể yếu → Khóa: (mã ứng viên, tên dự án)",
        "Dự án cá nhân (mã ứng viên, tên dự án, ngày bắt đầu, ngày kết thúc, mô tả, hình ảnh, liên kết)",
        "Xét Chứng chỉ (mã ứng viên, tên chứng chỉ, hình ảnh). Chứng chỉ là thực thể yếu → Khóa: (mã ứng viên, tên chứng chỉ)",
        "Chứng chỉ (mã ứng viên, tên chứng chỉ, hình ảnh)",
        "Xét Giải thưởng (mã ứng viên, tên giải thưởng, hình ảnh). Giải thưởng là thực thể yếu → Khóa: (mã ứng viên, tên giải thưởng)",
        "Giải thưởng (mã ứng viên, tên giải thưởng, hình ảnh)",
        "Xét Hoạt động ngoại khóa (mã ứng viên, tên tổ chức, vai trò, đang tham gia, ngày bắt đầu, ngày kết thúc, mô tả, hình ảnh, liên kết). Hoạt động là thực thể yếu → Khóa: (mã ứng viên, tên tổ chức, vai trò)",
        "Hoạt động ngoại khóa (mã ứng viên, tên tổ chức, vai trò, đang tham gia, ngày bắt đầu, ngày kết thúc, mô tả, hình ảnh, liên kết)",
        "Xét Thông tin khác (mã ứng viên, tên mục, mô tả). Thông tin khác là thực thể yếu → Khóa: (mã ứng viên, tên mục)",
        "Thông tin khác (mã ứng viên, tên mục, mô tả)",
        "Xét Ngành nghề (tên ngành nghề). Ngành nghề chưa có thuộc tính định danh → Thêm \"mã ngành nghề\" → Khóa",
        "Ngành nghề (mã ngành nghề, tên ngành nghề)",
        "Xét Cấp bậc (tên cấp bậc). Cấp bậc chưa có thuộc tính định danh → Thêm \"mã cấp bậc\" → Khóa",
        "Cấp bậc (mã cấp bậc, tên cấp bậc)",
        "Xét Loại hình công việc (tên loại hình). Loại hình chưa có thuộc tính định danh → Thêm \"mã loại hình\" → Khóa",
        "Loại hình công việc (mã loại hình, tên loại hình)",
        "Xét Địa điểm (tên địa điểm). Địa điểm chưa có thuộc tính định danh → Thêm \"mã địa điểm\" → Khóa",
        "Địa điểm (mã địa điểm, tên địa điểm)",
        "Xét Hồ sơ CV (mã ứng viên, tiêu đề, họ tên, ...). Hồ sơ CV chưa có thuộc tính định danh → Thêm \"mã hồ sơ CV\" → Khóa",
        "Hồ sơ CV (mã hồ sơ CV, mã ứng viên, tiêu đề, họ tên, giới tính, ngày sinh, số điện thoại, email, địa chỉ, liên kết, ảnh đại diện, mục tiêu nghề nghiệp, tiêu đề các phần, liên kết CV, thứ tự các phần)",
        "Xét Tin nhắn thông báo (mã ứng viên, mã tin tuyển dụng, nội dung, trạng thái đã đọc). Tin nhắn chưa có thuộc tính định danh → Thêm \"mã tin nhắn\" → Khóa",
        "Tin nhắn thông báo (mã tin nhắn, mã ứng viên, mã tin tuyển dụng, nội dung, trạng thái đã đọc)",
    ]

    for text in reversed(new_entities_keyed):
        add_p(insert_after_key, text, "Normal")

doc.save('K62_211213818_BuiDucTaiAnh_CNTT4.docx')
print("Task 5 done: Sua hinh + Bo sung thuc the CSDL")
```

Run: `python scripts/task5_fix_ch3_entities.py`
Expected: "Task 5 done: Sua hinh + Bo sung thuc the CSDL"

- [ ] **Step 2: Commit**

```bash
git add scripts/task5_fix_ch3_entities.py K62_211213818_BuiDucTaiAnh_CNTT4.docx
git commit -m "docs: fix figure numbering and add missing DB entities to chapter 3"
```

---

### Task 6: Bo sung quan he N-N vao muc 3.2.2

**Files:**
- Modify: `K62_211213818_BuiDucTaiAnh_CNTT4.docx` (muc 3.2.2)

- [ ] **Step 1: Chay script bo sung quan he**

Tao file `scripts/task6_add_relationships.py`:

```python
from docx import Document
from docx.oxml.ns import qn
from docx.oxml import OxmlElement

doc = Document('K62_211213818_BuiDucTaiAnh_CNTT4.docx')

# Tim vi tri chen: sau dong cuoi cua muc 3.2.2 (truoc 3.2.3 ERD)
insert_after = None
for i, p in enumerate(doc.paragraphs):
    if 'Nhà tuyển dụng và Tin tuyển dụng có kiểu liên kết 1-N' in p.text:
        insert_after = p._element
        break

if insert_after is None:
    for i, p in enumerate(doc.paragraphs):
        if p.text.strip() == '3.2.3. Sơ đồ ERD và RM':
            insert_after = doc.paragraphs[i-1]._element
            break

def add_p(ref, text, style):
    new_p = OxmlElement('w:p')
    pPr = OxmlElement('w:pPr')
    pStyle = OxmlElement('w:pStyle')
    pStyle.set(qn('w:val'), style)
    pPr.append(pStyle)
    new_p.append(pPr)
    run = OxmlElement('w:r')
    t = OxmlElement('w:t')
    t.text = text
    t.set(qn('xml:space'), 'preserve')
    run.append(t)
    new_p.append(run)
    ref.addnext(new_p)
    return new_p

cur = insert_after

# Them cac quan he 1-N bo sung
new_1n = [
    "Giữa hai thực thể Ứng viên và Học vấn có kiểu liên kết 1-N vì một ứng viên có thể có nhiều thông tin học vấn và ngược lại một thông tin học vấn chỉ thuộc về một ứng viên.",
    "Giữa hai thực thể Ứng viên và Kinh nghiệm làm việc có kiểu liên kết 1-N vì một ứng viên có thể có nhiều kinh nghiệm và ngược lại một kinh nghiệm chỉ thuộc về một ứng viên.",
    "Giữa hai thực thể Ứng viên và Kỹ năng có kiểu liên kết 1-N vì một ứng viên có thể có nhiều kỹ năng và ngược lại một kỹ năng chỉ thuộc về một ứng viên.",
    "Giữa hai thực thể Ứng viên và Dự án cá nhân có kiểu liên kết 1-N vì một ứng viên có thể có nhiều dự án và ngược lại một dự án chỉ thuộc về một ứng viên.",
    "Giữa hai thực thể Ứng viên và Chứng chỉ có kiểu liên kết 1-N vì một ứng viên có thể có nhiều chứng chỉ và ngược lại một chứng chỉ chỉ thuộc về một ứng viên.",
    "Giữa hai thực thể Ứng viên và Giải thưởng có kiểu liên kết 1-N vì một ứng viên có thể có nhiều giải thưởng và ngược lại một giải thưởng chỉ thuộc về một ứng viên.",
    "Giữa hai thực thể Ứng viên và Hoạt động ngoại khóa có kiểu liên kết 1-N vì một ứng viên có thể có nhiều hoạt động và ngược lại một hoạt động chỉ thuộc về một ứng viên.",
    "Giữa hai thực thể Ứng viên và Thông tin khác có kiểu liên kết 1-N vì một ứng viên có thể có nhiều thông tin bổ sung và ngược lại một thông tin chỉ thuộc về một ứng viên.",
    "Giữa hai thực thể Ứng viên và Hồ sơ CV có kiểu liên kết 1-N vì một ứng viên có thể tạo nhiều CV và ngược lại một CV chỉ thuộc về một ứng viên.",
    "Giữa hai thực thể Ứng viên và Tin nhắn thông báo có kiểu liên kết 1-N vì một ứng viên có thể nhận nhiều tin nhắn và ngược lại một tin nhắn chỉ gửi cho một ứng viên.",
    "Giữa hai thực thể Loại hình công việc và Kinh nghiệm có kiểu liên kết 1-N vì một loại hình công việc tương ứng với nhiều kinh nghiệm và ngược lại một kinh nghiệm chỉ thuộc một loại hình.",
    "Giữa hai thực thể Loại hình công việc và Tin tuyển dụng có kiểu liên kết 1-N vì một loại hình tương ứng với nhiều tin tuyển dụng và ngược lại một tin chỉ thuộc một loại hình.",
    "Giữa hai thực thể Cấp bậc và Tin tuyển dụng có kiểu liên kết 1-N vì một cấp bậc tương ứng với nhiều tin tuyển dụng và ngược lại một tin chỉ thuộc một cấp bậc.",
]

for text in reversed(new_1n):
    add_p(insert_after, text, "Normal")

# Them heading N-N
nn_heading = add_p(insert_after, "", "Normal")  # blank line

# Tim lai vi tri cuoi (sau cac dong 1-N vua them)
# Tim dong cuoi cung cua phan 1-N moi them
cur2 = None
for i, p in enumerate(doc.paragraphs):
    if 'Cấp bậc và Tin tuyển dụng có kiểu liên kết 1-N' in p.text:
        cur2 = p._element
        break

if cur2:
    cur2 = add_p(cur2, "", "Normal")
    cur2 = add_p(cur2, "Kiểu liên kết N-N", "Normal")

    nn_relations = [
        "Giữa hai thực thể Tin tuyển dụng và Ngành nghề có kiểu liên kết N-N vì một tin tuyển dụng có thể thuộc nhiều ngành nghề và ngược lại một ngành nghề tương ứng với nhiều tin tuyển dụng. Kiểu liên kết này được thể hiện qua bảng trung gian job_industry (mã tin tuyển dụng, mã ngành nghề).",
        "Giữa hai thực thể Tin tuyển dụng và Địa điểm có kiểu liên kết N-N vì một tin tuyển dụng có thể tuyển tại nhiều địa điểm và ngược lại một địa điểm có nhiều tin tuyển dụng. Kiểu liên kết này được thể hiện qua bảng trung gian job_location (mã tin tuyển dụng, mã địa điểm).",
        "Giữa hai thực thể Tin tuyển dụng và Kỹ năng yêu cầu có kiểu liên kết N-N vì một tin tuyển dụng yêu cầu nhiều kỹ năng và ngược lại một kỹ năng được yêu cầu bởi nhiều tin. Kiểu liên kết này được thể hiện qua bảng trung gian job_skill (mã tin tuyển dụng, mã kỹ năng).",
        "Giữa hai thực thể Tin tuyển dụng và Thẻ tag có kiểu liên kết N-N vì một tin tuyển dụng có thể gắn nhiều tag và ngược lại một tag được gắn cho nhiều tin. Kiểu liên kết này được thể hiện qua bảng trung gian job_tag (mã tin tuyển dụng, mã tag).",
        "Giữa hai thực thể Nhà tuyển dụng và Địa điểm có kiểu liên kết N-N vì một nhà tuyển dụng có thể hoạt động tại nhiều địa điểm và ngược lại một địa điểm có nhiều nhà tuyển dụng. Kiểu liên kết này được thể hiện qua bảng trung gian employer_location (mã nhà tuyển dụng, mã địa điểm).",
        "Giữa hai thực thể Ứng viên và Tin tuyển dụng có kiểu liên kết N-N thông qua chức năng ứng tuyển: một ứng viên có thể ứng tuyển vào nhiều tin và ngược lại một tin nhận nhiều ứng viên. Kiểu liên kết này được thể hiện qua bảng trung gian job_applying (mã tin tuyển dụng, mã ứng viên, liên kết CV, trạng thái xử lý, thời gian tạo).",
        "Giữa hai thực thể Ứng viên và Tin tuyển dụng có kiểu liên kết N-N thông qua chức năng lưu tin: một ứng viên có thể lưu nhiều tin và ngược lại một tin được lưu bởi nhiều ứng viên. Kiểu liên kết này được thể hiện qua bảng trung gian saved_jobs (mã ứng viên, mã tin tuyển dụng).",
    ]

    for text in nn_relations:
        cur2 = add_p(cur2, text, "Normal")
        cur2 = add_p(cur2, "", "Normal")

doc.save('K62_211213818_BuiDucTaiAnh_CNTT4.docx')
print("Task 6 done: Bo sung quan he 1-N va N-N")
```

Run: `python scripts/task6_add_relationships.py`
Expected: "Task 6 done: Bo sung quan he 1-N va N-N"

- [ ] **Step 2: Commit**

```bash
git add scripts/task6_add_relationships.py K62_211213818_BuiDucTaiAnh_CNTT4.docx
git commit -m "docs: add 1-N and N-N relationships to chapter 3"
```

---

### Task 7: Them Class Diagram va Data Dictionary vao Chuong 3

**Files:**
- Modify: `K62_211213818_BuiDucTaiAnh_CNTT4.docx` (sau muc 3.2, truoc 3.3)

- [ ] **Step 1: Chay script them Class Diagram va Data Dictionary**

Tao file `scripts/task7_add_class_datadict.py`:

```python
from docx import Document
from docx.oxml.ns import qn
from docx.oxml import OxmlElement

doc = Document('K62_211213818_BuiDucTaiAnh_CNTT4.docx')

# Tim vi tri chen: truoc "3.3. Thiet ke kiem soat"
insert_before = None
for i, p in enumerate(doc.paragraphs):
    if p.text.strip() == '3.3. Thiết kế kiểm soát':
        insert_before = p._element
        break

def add_p_before(ref, text, style):
    new_p = OxmlElement('w:p')
    pPr = OxmlElement('w:pPr')
    pStyle = OxmlElement('w:pStyle')
    pStyle.set(qn('w:val'), style)
    pPr.append(pStyle)
    new_p.append(pPr)
    run = OxmlElement('w:r')
    t = OxmlElement('w:t')
    t.text = text
    t.set(qn('xml:space'), 'preserve')
    run.append(t)
    new_p.append(run)
    ref.addprevious(new_p)
    return new_p

def add_table_before(ref, headers, rows):
    tbl = OxmlElement('w:tbl')
    tblPr = OxmlElement('w:tblPr')
    tblStyle = OxmlElement('w:tblStyle')
    tblStyle.set(qn('w:val'), 'TableGrid')
    tblPr.append(tblStyle)
    tblW = OxmlElement('w:tblW')
    tblW.set(qn('w:w'), '5000')
    tblW.set(qn('w:type'), 'pct')
    tblPr.append(tblW)
    tbl.append(tblPr)
    tblGrid = OxmlElement('w:tblGrid')
    for _ in headers:
        gridCol = OxmlElement('w:gridCol')
        gridCol.set(qn('w:w'), str(9000 // len(headers)))
        tblGrid.append(gridCol)
    tbl.append(tblGrid)
    def make_row(cells, bold=False):
        tr = OxmlElement('w:tr')
        for c in cells:
            tc = OxmlElement('w:tc')
            p = OxmlElement('w:p')
            r = OxmlElement('w:r')
            if bold:
                rPr = OxmlElement('w:rPr')
                b = OxmlElement('w:b')
                rPr.append(b)
                r.append(rPr)
            t_el = OxmlElement('w:t')
            t_el.text = c
            t_el.set(qn('xml:space'), 'preserve')
            r.append(t_el)
            p.append(r)
            tc.append(p)
            tr.append(tc)
        return tr
    tbl.append(make_row(headers, True))
    for row in rows:
        tbl.append(make_row(row))
    ref.addprevious(tbl)
    return tbl

# === PHAN 1: CLASS DIAGRAM ===
add_p_before(insert_before, "", "Normal")
add_p_before(insert_before, "3.2.4. Biểu đồ lớp (Class Diagram)", "Heading 3")
add_p_before(insert_before, "Biểu đồ lớp mô tả cấu trúc các lớp Model trong hệ thống Backend Laravel và mối quan hệ giữa chúng. Mỗi lớp Model tương ứng với một bảng trong cơ sở dữ liệu và định nghĩa các thuộc tính (attributes) cùng các mối quan hệ (relationships) với các Model khác.", "Normal")

# Bang mo ta cac class
class_headers = ["Tên lớp (Model)", "Bảng CSDL", "Quan hệ chính"]
class_rows = [
    ["User", "users", "hasOne(Candidate), hasOne(Employer)"],
    ["Candidate", "candidates", "belongsTo(User), hasMany(Education), hasMany(Experience), hasMany(Skill), hasMany(Project), hasMany(Certificate), hasMany(Prize), hasMany(Activity), hasMany(Other), hasMany(Resume), hasMany(CandidateMessage), belongsToMany(Job) qua job_applying, belongsToMany(Job) qua saved_jobs"],
    ["Employer", "employers", "belongsTo(User), hasMany(Job), belongsToMany(Location)"],
    ["Job", "jobs", "belongsTo(Employer), belongsTo(Jtype), belongsTo(Jlevel), belongsToMany(Industry), belongsToMany(Location), belongsToMany(Jskill), belongsToMany(Jtag), belongsToMany(Candidate) qua job_applying"],
    ["Resume", "resumes", "belongsTo(Candidate)"],
    ["Education", "educations", "belongsTo(Candidate)"],
    ["Experience", "experiences", "belongsTo(Candidate), belongsTo(Jtype)"],
    ["Skill", "skills", "belongsTo(Candidate)"],
    ["Project", "projects", "belongsTo(Candidate)"],
    ["Certificate", "certificates", "belongsTo(Candidate)"],
    ["Prize", "prizes", "belongsTo(Candidate)"],
    ["Activity", "activities", "belongsTo(Candidate)"],
    ["Other", "others", "belongsTo(Candidate)"],
    ["Industry", "industries", "belongsToMany(Job)"],
    ["Location", "locations", "belongsToMany(Job), belongsToMany(Employer)"],
    ["Jtype", "jtypes", "hasMany(Job), hasMany(Experience)"],
    ["Jlevel", "jlevels", "hasMany(Job)"],
    ["Jskill", "jskills", "belongsToMany(Job)"],
    ["Jtag", "jtags", "belongsToMany(Job)"],
    ["CandidateMessage", "candidate_messages", "belongsTo(Candidate), belongsTo(Job)"],
]
add_table_before(insert_before, class_headers, class_rows)
add_p_before(insert_before, "Bảng 3.13: Danh sách các lớp Model và quan hệ", "Bảng")

add_p_before(insert_before, "(Chèn biểu đồ lớp tại đây)", "hinh")
add_p_before(insert_before, "Hình 3.3: Biểu đồ lớp (Class Diagram) của hệ thống", "hinh")

# === PHAN 2: DATA DICTIONARY ===
add_p_before(insert_before, "", "Normal")
add_p_before(insert_before, "3.2.5. Từ điển dữ liệu (Data Dictionary)", "Heading 3")
add_p_before(insert_before, "Từ điển dữ liệu mô tả chi tiết cấu trúc các bảng chính trong cơ sở dữ liệu hệ thống, bao gồm tên cột, kiểu dữ liệu, mô tả và ràng buộc.", "Normal")

# Bang users
add_p_before(insert_before, "Bảng users - Lưu thông tin tài khoản người dùng:", "Normal")
dd_headers = ["Tên cột", "Kiểu dữ liệu", "Mô tả", "Ràng buộc"]
users_rows = [
    ["id", "BIGINT UNSIGNED", "Mã tài khoản", "PRIMARY KEY, AUTO_INCREMENT"],
    ["email", "VARCHAR(255)", "Địa chỉ email đăng nhập", "NOT NULL, UNIQUE"],
    ["password", "VARCHAR(255)", "Mật khẩu đã mã hóa", "NOT NULL"],
    ["role", "TINYINT UNSIGNED", "Vai trò (0: ứng viên, 1: NTD)", "NOT NULL"],
    ["is_active", "TINYINT(1)", "Trạng thái hoạt động", "NOT NULL"],
    ["created_at", "TIMESTAMP", "Thời gian tạo", "NULLABLE"],
    ["updated_at", "TIMESTAMP", "Thời gian cập nhật", "NULLABLE"],
]
add_table_before(insert_before, dd_headers, users_rows)
add_p_before(insert_before, "Bảng 3.14a: Cấu trúc bảng users", "Bảng")

# Bang candidates
add_p_before(insert_before, "Bảng candidates - Lưu thông tin ứng viên:", "Normal")
cand_rows = [
    ["id", "BIGINT UNSIGNED", "Mã ứng viên", "PRIMARY KEY, AUTO_INCREMENT"],
    ["user_id", "BIGINT UNSIGNED", "Mã tài khoản liên kết", "FOREIGN KEY → users(id)"],
    ["firstname", "VARCHAR(50)", "Tên", "NOT NULL"],
    ["lastname", "VARCHAR(50)", "Họ", "NOT NULL"],
    ["gender", "TINYINT UNSIGNED", "Giới tính (0: nam, 1: nữ)", "NULLABLE"],
    ["dob", "DATE", "Ngày sinh", "NULLABLE"],
    ["phone", "CHAR(10)", "Số điện thoại", "NULLABLE"],
    ["email", "VARCHAR(255)", "Email liên hệ", "NOT NULL"],
    ["address", "VARCHAR(255)", "Địa chỉ", "NULLABLE"],
    ["link", "TEXT", "Liên kết cá nhân", "NULLABLE"],
    ["objective", "TEXT", "Mục tiêu nghề nghiệp", "NULLABLE"],
    ["avatar", "TEXT", "Đường dẫn ảnh đại diện", "NULLABLE"],
]
add_table_before(insert_before, dd_headers, cand_rows)
add_p_before(insert_before, "Bảng 3.14b: Cấu trúc bảng candidates", "Bảng")

# Bang employers
add_p_before(insert_before, "Bảng employers - Lưu thông tin nhà tuyển dụng:", "Normal")
emp_rows = [
    ["id", "BIGINT UNSIGNED", "Mã nhà tuyển dụng", "PRIMARY KEY, AUTO_INCREMENT"],
    ["user_id", "BIGINT UNSIGNED", "Mã tài khoản liên kết", "FOREIGN KEY → users(id)"],
    ["name", "VARCHAR(100)", "Tên công ty", "NOT NULL"],
    ["address", "VARCHAR(255)", "Địa chỉ trụ sở", "NOT NULL"],
    ["min_employees", "INT UNSIGNED", "Quy mô nhân sự tối thiểu", "NULLABLE"],
    ["max_employees", "INT UNSIGNED", "Quy mô nhân sự tối đa", "NULLABLE"],
    ["contact_name", "VARCHAR(60)", "Tên người liên hệ", "NULLABLE"],
    ["phone", "VARCHAR(15)", "Số điện thoại", "NULLABLE"],
    ["website", "VARCHAR(255)", "Website công ty", "NULLABLE"],
    ["description", "LONGTEXT", "Mô tả công ty", "NULLABLE"],
    ["logo", "TEXT", "Đường dẫn logo", "NOT NULL"],
    ["image", "TEXT", "Đường dẫn ảnh bìa", "NULLABLE"],
    ["is_hot", "TINYINT(1)", "Nhà tuyển dụng nổi bật", "NOT NULL"],
    ["is_active", "TINYINT(1)", "Trạng thái hoạt động", "NOT NULL"],
]
add_table_before(insert_before, dd_headers, emp_rows)
add_p_before(insert_before, "Bảng 3.14c: Cấu trúc bảng employers", "Bảng")

# Bang jobs
add_p_before(insert_before, "Bảng jobs - Lưu thông tin tin tuyển dụng:", "Normal")
jobs_rows = [
    ["id", "BIGINT UNSIGNED", "Mã tin tuyển dụng", "PRIMARY KEY, AUTO_INCREMENT"],
    ["employer_id", "BIGINT UNSIGNED", "Mã nhà tuyển dụng", "FOREIGN KEY → employers(id)"],
    ["jtype_id", "BIGINT UNSIGNED", "Mã loại hình công việc", "FOREIGN KEY → jtypes(id)"],
    ["jlevel_id", "BIGINT UNSIGNED", "Mã cấp bậc", "FOREIGN KEY → jlevels(id)"],
    ["jname", "VARCHAR(150)", "Tên vị trí tuyển dụng", "NOT NULL"],
    ["address", "TEXT", "Địa chỉ làm việc", "NOT NULL"],
    ["amount", "INT UNSIGNED", "Số lượng tuyển", "NULLABLE"],
    ["min_salary", "INT UNSIGNED", "Mức lương tối thiểu", "NULLABLE"],
    ["max_salary", "INT UNSIGNED", "Mức lương tối đa", "NULLABLE"],
    ["yoe", "TINYINT UNSIGNED", "Số năm kinh nghiệm yêu cầu", "NULLABLE"],
    ["gender", "TINYINT UNSIGNED", "Giới tính yêu cầu", "NULLABLE"],
    ["description", "LONGTEXT", "Mô tả công việc", "NOT NULL"],
    ["expire_at", "DATE", "Hạn nộp hồ sơ", "NOT NULL"],
    ["is_hot", "TINYINT(1)", "Tin nổi bật", "NOT NULL, DEFAULT 0"],
    ["is_active", "TINYINT(1)", "Trạng thái tin", "NOT NULL, DEFAULT 1"],
]
add_table_before(insert_before, dd_headers, jobs_rows)
add_p_before(insert_before, "Bảng 3.14d: Cấu trúc bảng jobs", "Bảng")

# Bang resumes
add_p_before(insert_before, "Bảng resumes - Lưu thông tin CV/Resume trực tuyến:", "Normal")
resumes_rows = [
    ["id", "BIGINT UNSIGNED", "Mã hồ sơ CV", "PRIMARY KEY, AUTO_INCREMENT"],
    ["candidate_id", "BIGINT UNSIGNED", "Mã ứng viên", "FOREIGN KEY → candidates(id)"],
    ["title", "VARCHAR(60)", "Tiêu đề CV", "NULLABLE"],
    ["fullname", "VARCHAR(100)", "Họ tên trên CV", "NULLABLE"],
    ["gender", "TINYINT UNSIGNED", "Giới tính", "NULLABLE"],
    ["dob", "DATE", "Ngày sinh", "NULLABLE"],
    ["phone", "CHAR(10)", "Số điện thoại", "NULLABLE"],
    ["email", "VARCHAR(255)", "Email", "NULLABLE"],
    ["address", "VARCHAR(255)", "Địa chỉ", "NULLABLE"],
    ["objective", "TEXT", "Mục tiêu nghề nghiệp", "NULLABLE"],
    ["avatar", "TEXT", "Ảnh đại diện CV", "NULLABLE"],
    ["cv_link", "TEXT", "Liên kết CV đã xuất", "NULLABLE"],
    ["parts_order", "JSON", "Thứ tự các phần trong CV", "NULLABLE"],
]
add_table_before(insert_before, dd_headers, resumes_rows)
add_p_before(insert_before, "Bảng 3.14e: Cấu trúc bảng resumes", "Bảng")

# Bang job_applying
add_p_before(insert_before, "Bảng job_applying - Lưu thông tin ứng tuyển:", "Normal")
applying_rows = [
    ["job_id", "BIGINT UNSIGNED", "Mã tin tuyển dụng", "FOREIGN KEY → jobs(id)"],
    ["candidate_id", "BIGINT UNSIGNED", "Mã ứng viên", "FOREIGN KEY → candidates(id)"],
    ["cv_link", "TEXT", "Đường dẫn CV đã nộp", "NULLABLE"],
    ["status", "TINYINT UNSIGNED", "Trạng thái (0: chờ, 1: đã xem, 2: chấp nhận, 3: từ chối)", "NOT NULL, DEFAULT 0"],
    ["created_at", "TIMESTAMP", "Thời gian ứng tuyển", "NULLABLE"],
    ["updated_at", "TIMESTAMP", "Thời gian cập nhật", "NULLABLE"],
]
add_table_before(insert_before, dd_headers, applying_rows)
add_p_before(insert_before, "Bảng 3.14f: Cấu trúc bảng job_applying", "Bảng")

# Bang saved_jobs
add_p_before(insert_before, "Bảng saved_jobs - Lưu tin tuyển dụng đã lưu:", "Normal")
saved_rows = [
    ["candidate_id", "BIGINT UNSIGNED", "Mã ứng viên", "FOREIGN KEY → candidates(id)"],
    ["job_id", "BIGINT UNSIGNED", "Mã tin tuyển dụng", "FOREIGN KEY → jobs(id)"],
]
add_table_before(insert_before, dd_headers, saved_rows)
add_p_before(insert_before, "Bảng 3.14g: Cấu trúc bảng saved_jobs", "Bảng")

doc.save('K62_211213818_BuiDucTaiAnh_CNTT4.docx')
print("Task 7 done: Them Class Diagram va Data Dictionary")
```

Run: `python scripts/task7_add_class_datadict.py`
Expected: "Task 7 done: Them Class Diagram va Data Dictionary"

- [ ] **Step 2: Commit**

```bash
git add scripts/task7_add_class_datadict.py K62_211213818_BuiDucTaiAnh_CNTT4.docx
git commit -m "docs: add class diagram and data dictionary to chapter 3"
```

---

### Task 8: Cap nhat bang phan quyen (3.3) cho cac thuc the moi

**Files:**
- Modify: `K62_211213818_BuiDucTaiAnh_CNTT4.docx` (bang 3.14 va 3.15)

- [ ] **Step 1: Chay script cap nhat bang phan quyen**

Tao file `scripts/task8_update_permissions.py`:

```python
from docx import Document
from docx.oxml.ns import qn
from docx.oxml import OxmlElement

doc = Document('K62_211213818_BuiDucTaiAnh_CNTT4.docx')

# === Cap nhat bang phan quyen du lieu (table 14) ===
# Them cac hang moi vao bang
table_data = doc.tables[14]

new_data_rows = [
    ["tbl_HocVan", "C, R, E, D", "", "C, R, E, D"],
    ["tbl_KinhNghiem", "C, R, E, D", "", "C, R, E, D"],
    ["tbl_KyNang", "C, R, E, D", "", "C, R, E, D"],
    ["tbl_DuAn", "C, R, E, D", "", "C, R, E, D"],
    ["tbl_ChungChi", "C, R, E, D", "", "C, R, E, D"],
    ["tbl_GiaiThuong", "C, R, E, D", "", "C, R, E, D"],
    ["tbl_HoatDong", "C, R, E, D", "", "C, R, E, D"],
    ["tbl_ThongTinKhac", "C, R, E, D", "", "C, R, E, D"],
    ["tbl_HoSoCV", "C, R, E, D", "", "C, R, E, D"],
    ["tbl_NganhNghe", "R", "R", "C, R, E, D"],
    ["tbl_CapBac", "R", "R", "C, R, E, D"],
    ["tbl_LoaiHinh", "R", "R", "C, R, E, D"],
    ["tbl_DiaDiem", "R", "R", "C, R, E, D"],
    ["tbl_TinNhan", "R", "", "C, R, E, D"],
    ["tbl_UngTuyen", "C, R", "R, E", "C, R, E, D"],
    ["tbl_LuuTin", "C, R, D", "", "C, R, E, D"],
]

ref_tbl = table_data._tbl
# Lay mau row tu row cuoi cung
last_row = ref_tbl.findall(qn('w:tr'))[-1]

for row_data in new_data_rows:
    from copy import deepcopy
    new_tr = deepcopy(last_row)
    cells = new_tr.findall(qn('w:tc'))
    for c_idx, cell in enumerate(cells):
        for p in cell.findall(qn('w:p')):
            for r in p.findall(qn('w:r')):
                for t in r.findall(qn('w:t')):
                    t.text = row_data[c_idx]
    ref_tbl.append(new_tr)

# === Cap nhat bang phan quyen chuc nang (table 15) ===
table_func = doc.tables[15]
ref_tbl2 = table_func._tbl
last_row2 = ref_tbl2.findall(qn('w:tr'))[-1]

new_func_rows = [
    ["Quản lý học vấn", "A", "not A", "A"],
    ["Quản lý kinh nghiệm", "A", "not A", "A"],
    ["Quản lý kỹ năng", "A", "not A", "A"],
    ["Quản lý dự án", "A", "not A", "A"],
    ["Quản lý chứng chỉ", "A", "not A", "A"],
    ["Quản lý giải thưởng", "A", "not A", "A"],
    ["Quản lý hoạt động", "A", "not A", "A"],
    ["Quản lý thông tin khác", "A", "not A", "A"],
    ["Quản lý CV/Resume", "A", "not A", "A"],
    ["Xem thông báo kết quả", "A", "not A", "A"],
    ["Tìm kiếm nhà tuyển dụng", "A", "A", "A"],
]

for row_data in new_func_rows:
    from copy import deepcopy
    new_tr = deepcopy(last_row2)
    cells = new_tr.findall(qn('w:tc'))
    for c_idx, cell in enumerate(cells):
        for p in cell.findall(qn('w:p')):
            for r in p.findall(qn('w:r')):
                for t in r.findall(qn('w:t')):
                    t.text = row_data[c_idx]
    ref_tbl2.append(new_tr)

doc.save('K62_211213818_BuiDucTaiAnh_CNTT4.docx')
print("Task 8 done: Cap nhat bang phan quyen")
```

Run: `python scripts/task8_update_permissions.py`
Expected: "Task 8 done: Cap nhat bang phan quyen"

- [ ] **Step 2: Commit**

```bash
git add scripts/task8_update_permissions.py K62_211213818_BuiDucTaiAnh_CNTT4.docx
git commit -m "docs: update permission tables with new entities and functions"
```

---

### Task 9: Kiem tra ket qua va tao ban cuoi cung

- [ ] **Step 1: Chay script kiem tra toan bo noi dung da them**

Tao file `scripts/task9_verify.py`:

```python
from docx import Document

doc = Document('K62_211213818_BuiDucTaiAnh_CNTT4.docx')

checks = {
    "Chuc nang quan ly hoc van": False,
    "2.2.3. Chức năng quản lý hồ sơ ứng viên": False,
    "2.4. Biểu đồ ca sử dụng": False,
    "2.5. Biểu đồ tuần tự": False,
    "Hình 3.1": False,
    "3.2.4. Biểu đồ lớp": False,
    "3.2.5. Từ điển dữ liệu": False,
    "Kiểu liên kết N-N": False,
    "Quản lý học vấn": False,
}

for p in doc.paragraphs:
    for key in checks:
        if key in p.text:
            checks[key] = True

print("=== Kiem tra noi dung da bo sung ===")
all_pass = True
for key, found in checks.items():
    status = "OK" if found else "MISSING"
    if not found:
        all_pass = False
    print(f"  [{status}] {key}")

print(f"\nTong so paragraphs: {len(doc.paragraphs)}")
print(f"Tong so tables: {len(doc.tables)}")
print(f"\nKet qua: {'PASS - Tat ca noi dung da duoc bo sung' if all_pass else 'FAIL - Con thieu noi dung'}")
```

Run: `python scripts/task9_verify.py`
Expected: All items show [OK] and "PASS - Tat ca noi dung da duoc bo sung"

- [ ] **Step 2: Commit ket qua cuoi cung**

```bash
git add scripts/task9_verify.py K62_211213818_BuiDucTaiAnh_CNTT4.docx
git commit -m "docs: verify and finalize report improvements for chapter 2 & 3"
```

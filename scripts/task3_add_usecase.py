"""
Task 3: Add section 2.4 Use Case Diagram to the docx document.
Inserts after the paragraph containing both "Hình 2.5" and "mức dưới đỉnh".
"""

from copy import deepcopy
from docx import Document
from docx.oxml.ns import qn
from lxml import etree

DOC_PATH = "D:/JobPotal/recruitment_web-xw1rpa/recruitment_web/K62_211213818_BuiDucTaiAnh_CNTT4.docx"

W = "http://schemas.openxmlformats.org/wordprocessingml/2006/main"

# --- Table data ---

ACTOR_TABLE_HEADERS = ["STT", "Tác nhân", "Mô tả"]
ACTOR_TABLE_ROWS = [
    ["1", "Ứng viên (Candidate)", "Người tìm việc sử dụng hệ thống để đăng ký, tạo hồ sơ, tìm kiếm việc làm, ứng tuyển và quản lý thông tin cá nhân."],
    ["2", "Nhà tuyển dụng (Employer)", "Doanh nghiệp sử dụng hệ thống để đăng tin tuyển dụng, quản lý danh sách ứng viên, xem hồ sơ và xử lý đơn ứng tuyển."],
]

CANDIDATE_UC_HEADERS = ["Mã UC", "Tên ca sử dụng", "Mô tả ngắn"]
CANDIDATE_UC_ROWS = [
    ["UC01", "Đăng ký tài khoản", "Tạo tài khoản ứng viên mới với email và mật khẩu"],
    ["UC02", "Đăng nhập", "Xác thực người dùng bằng email, mật khẩu và nhận JWT token"],
    ["UC03", "Đăng xuất", "Kết thúc phiên làm việc, xóa thông tin xác thực"],
    ["UC04", "Cập nhật tài khoản", "Thay đổi email, mật khẩu"],
    ["UC05", "Cập nhật thông tin cá nhân", "Cập nhật họ tên, ngày sinh, giới tính, SĐT, địa chỉ, ảnh đại diện, mục tiêu"],
    ["UC06", "Quản lý học vấn", "Thêm, sửa, xóa thông tin học vấn"],
    ["UC07", "Quản lý kinh nghiệm", "Thêm, sửa, xóa kinh nghiệm làm việc"],
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

EMPLOYER_UC_HEADERS = ["Mã UC", "Tên ca sử dụng", "Mô tả ngắn"]
EMPLOYER_UC_ROWS = [
    ["UC19", "Đăng nhập", "Xác thực nhà tuyển dụng bằng email, mật khẩu"],
    ["UC20", "Đăng xuất", "Kết thúc phiên làm việc"],
    ["UC21", "Cập nhật thông tin công ty", "Cập nhật tên, địa chỉ, quy mô, liên hệ, mô tả, logo, ảnh bìa, website"],
    ["UC22", "Tạo tin tuyển dụng", "Đăng tin mới với thông tin vị trí, yêu cầu, mức lương, ngành nghề, địa điểm"],
    ["UC23", "Cập nhật tin tuyển dụng", "Sửa thông tin và thay đổi trạng thái tin (bật/tắt)"],
    ["UC24", "Xem danh sách ứng viên", "Xem danh sách ứng viên đã ứng tuyển vào các tin"],
    ["UC25", "Xử lý hồ sơ ứng tuyển", "Xem CV, chấp nhận, từ chối hoặc mời phỏng vấn ứng viên"],
]


def find_template_paragraph(doc, style_name):
    """Find a template paragraph with the given style to copy formatting from."""
    for para in doc.paragraphs:
        if para.style.name == style_name and para.runs:
            return para
    return None


def get_style_id(doc, style_name):
    for s in doc.styles:
        if s.name == style_name:
            return s.style_id
    return style_name


def make_paragraph(style_name, text, doc, bold=False):
    """Create a new paragraph XML element with the given style and text."""
    template_para = find_template_paragraph(doc, style_name)

    if template_para is not None:
        p = deepcopy(template_para._element)
        # Remove all runs and non-pPr children
        for child in list(p):
            tag = child.tag.split('}')[-1]
            if tag != 'pPr':
                p.remove(child)
        # Add new run
        r = etree.SubElement(p, f'{{{W}}}r')
        if template_para.runs:
            rPr_src = template_para.runs[0]._element.find(f'{{{W}}}rPr')
            if rPr_src is not None:
                new_rPr = deepcopy(rPr_src)
                if bold:
                    b_elem = new_rPr.find(f'{{{W}}}b')
                    if b_elem is None:
                        etree.SubElement(new_rPr, f'{{{W}}}b')
                r.insert(0, new_rPr)
            elif bold:
                rPr = etree.SubElement(r, f'{{{W}}}rPr')
                r.insert(0, rPr)
                etree.SubElement(rPr, f'{{{W}}}b')
        elif bold:
            rPr = etree.Element(f'{{{W}}}rPr')
            etree.SubElement(rPr, f'{{{W}}}b')
            r.insert(0, rPr)
        t = etree.SubElement(r, f'{{{W}}}t')
        t.text = text
        t.set(f'{{{W}}}space', "preserve")
    else:
        p = etree.Element(f'{{{W}}}p')
        pPr = etree.SubElement(p, f'{{{W}}}pPr')
        pStyle = etree.SubElement(pPr, f'{{{W}}}pStyle')
        pStyle.set(f'{{{W}}}val', get_style_id(doc, style_name))
        r = etree.SubElement(p, f'{{{W}}}r')
        if bold:
            rPr = etree.SubElement(r, f'{{{W}}}rPr')
            etree.SubElement(rPr, f'{{{W}}}b')
        t = etree.SubElement(r, f'{{{W}}}t')
        t.text = text
        t.set(f'{{{W}}}space', "preserve")

    return p


def make_table(headers, rows, doc):
    """Create a 3-column table using OxmlElement with TableGrid style and bold headers."""
    num_cols = len(headers)
    num_rows = len(rows) + 1  # +1 for header

    # Create tbl element
    tbl = etree.Element(f'{{{W}}}tbl')

    # Table properties
    tblPr = etree.SubElement(tbl, f'{{{W}}}tblPr')
    tblStyle = etree.SubElement(tblPr, f'{{{W}}}tblStyle')
    tblStyle.set(f'{{{W}}}val', "TableGrid")
    tblW = etree.SubElement(tblPr, f'{{{W}}}tblW')
    tblW.set(f'{{{W}}}w', "0")
    tblW.set(f'{{{W}}}type', "auto")
    tblLook = etree.SubElement(tblPr, f'{{{W}}}tblLook')
    tblLook.set(f'{{{W}}}val', "04A0")
    tblLook.set(f'{{{W}}}firstRow', "1")
    tblLook.set(f'{{{W}}}lastRow', "0")
    tblLook.set(f'{{{W}}}firstColumn', "1")
    tblLook.set(f'{{{W}}}lastColumn', "0")
    tblLook.set(f'{{{W}}}noHBand', "0")
    tblLook.set(f'{{{W}}}noVBand', "1")

    # Table grid
    tblGrid = etree.SubElement(tbl, f'{{{W}}}tblGrid')
    for _ in range(num_cols):
        etree.SubElement(tblGrid, f'{{{W}}}gridCol')

    def make_cell(text, is_bold=False):
        tc = etree.Element(f'{{{W}}}tc')
        p = etree.SubElement(tc, f'{{{W}}}p')
        r = etree.SubElement(p, f'{{{W}}}r')
        if is_bold:
            rPr = etree.SubElement(r, f'{{{W}}}rPr')
            b = etree.SubElement(rPr, f'{{{W}}}b')
        t = etree.SubElement(r, f'{{{W}}}t')
        t.text = text
        t.set(f'{{{W}}}space', "preserve")
        return tc

    # Header row
    tr_header = etree.SubElement(tbl, f'{{{W}}}tr')
    for h in headers:
        tr_header.append(make_cell(h, is_bold=True))

    # Data rows
    for row in rows:
        tr = etree.SubElement(tbl, f'{{{W}}}tr')
        for cell_text in row:
            tr.append(make_cell(cell_text, is_bold=False))

    return tbl


def main():
    doc = Document(DOC_PATH)

    # Find insertion point: paragraph with style "hinh" containing both "Hình 2.5" and "mức dưới đỉnh"
    insert_after = None
    for para in doc.paragraphs:
        if "Hình 2.5" in para.text and "mức dưới đỉnh" in para.text and para.style.name == "hinh":
            insert_after = para._element
            break

    if insert_after is None:
        # Fallback: insert before "CHƯƠNG 3: THIẾT KẾ HỆ THỐNG"
        for para in doc.paragraphs:
            if "CHƯƠNG 3" in para.text:
                # Insert before this paragraph - use the previous sibling
                insert_after = para._element.getprevious()
                break

    if insert_after is None:
        raise RuntimeError("Could not find insertion point")

    print(f"Inserting after: {insert_after.text[:80] if hasattr(insert_after, 'text') else 'element'}")

    current = insert_after

    # 1. Heading 2: section title
    h2 = make_paragraph("Heading 2", "2.4. Biểu đồ ca sử dụng (Use Case Diagram)", doc)
    current.addnext(h2)
    current = h2

    # 2. Normal: intro paragraph
    p1 = make_paragraph("Normal",
        "Biểu đồ ca sử dụng (Use Case Diagram) mô tả các chức năng mà hệ thống cung cấp cho từng loại người dùng. "
        "Hệ thống website tuyển dụng có hai tác nhân chính: Ứng viên và Nhà tuyển dụng. "
        "Mỗi tác nhân có các ca sử dụng tương ứng với vai trò và quyền hạn của mình trong hệ thống.",
        doc)
    current.addnext(p1)
    current = p1

    # 3. Heading 3: 2.4.1
    h3_1 = make_paragraph("Heading 3", "2.4.1. Xác định tác nhân (Actor)", doc)
    current.addnext(h3_1)
    current = h3_1

    # 4. Normal: actor intro
    p2 = make_paragraph("Normal", "Hệ thống có hai tác nhân chính tương tác trực tiếp với hệ thống:", doc)
    current.addnext(p2)
    current = p2

    # 5. Actor table
    tbl1 = make_table(ACTOR_TABLE_HEADERS, ACTOR_TABLE_ROWS, doc)
    current.addnext(tbl1)
    current = tbl1

    # 6. Caption for actor table
    cap1 = make_paragraph("Bảng", "Bảng 2.21: Danh sách tác nhân hệ thống", doc)
    current.addnext(cap1)
    current = cap1

    # 7. Heading 3: 2.4.2
    h3_2 = make_paragraph("Heading 3", "2.4.2. Danh sách ca sử dụng", doc)
    current.addnext(h3_2)
    current = h3_2

    # 8. Normal: candidate UC intro
    p3 = make_paragraph("Normal", "Danh sách ca sử dụng của tác nhân Ứng viên:", doc)
    current.addnext(p3)
    current = p3

    # 9. Candidate UC table
    tbl2 = make_table(CANDIDATE_UC_HEADERS, CANDIDATE_UC_ROWS, doc)
    current.addnext(tbl2)
    current = tbl2

    # 10. Caption for candidate UC table
    cap2 = make_paragraph("Bảng", "Bảng 2.22: Danh sách ca sử dụng của Ứng viên", doc)
    current.addnext(cap2)
    current = cap2

    # 11. Normal: employer UC intro
    p4 = make_paragraph("Normal", "Danh sách ca sử dụng của tác nhân Nhà tuyển dụng:", doc)
    current.addnext(p4)
    current = p4

    # 12. Employer UC table
    tbl3 = make_table(EMPLOYER_UC_HEADERS, EMPLOYER_UC_ROWS, doc)
    current.addnext(tbl3)
    current = tbl3

    # 13. Caption for employer UC table
    cap3 = make_paragraph("Bảng", "Bảng 2.23: Danh sách ca sử dụng của Nhà tuyển dụng", doc)
    current.addnext(cap3)
    current = cap3

    # 14. Heading 3: 2.4.3
    h3_3 = make_paragraph("Heading 3", "2.4.3. Biểu đồ ca sử dụng tổng quát", doc)
    current.addnext(h3_3)
    current = h3_3

    # 15. Normal: general UC diagram description
    p5 = make_paragraph("Normal",
        "Biểu đồ ca sử dụng tổng quát mô tả tổng quan các chức năng mà hệ thống cung cấp cho hai tác nhân. "
        "Ứng viên có thể thực hiện các ca sử dụng từ UC01 đến UC18, bao gồm đăng ký, quản lý hồ sơ cá nhân, "
        "tạo CV, tìm kiếm việc làm và ứng tuyển. Nhà tuyển dụng có thể thực hiện các ca sử dụng từ UC19 đến UC25, "
        "bao gồm quản lý thông tin công ty, đăng tin tuyển dụng và xử lý hồ sơ ứng viên. "
        "Hai tác nhân chia sẻ chung các ca sử dụng đăng nhập và đăng xuất.",
        doc)
    current.addnext(p5)
    current = p5

    # 16. hinh: placeholder
    p6 = make_paragraph("hinh", "(Chèn biểu đồ Use Case tổng quát tại đây)", doc)
    current.addnext(p6)
    current = p6

    # 17. hinh: figure caption
    p7 = make_paragraph("hinh", "Hình 2.6: Biểu đồ ca sử dụng tổng quát của hệ thống", doc)
    current.addnext(p7)
    current = p7

    doc.save(DOC_PATH)
    print("Document saved successfully.")

    # Verify
    doc2 = Document(DOC_PATH)
    print(f"\nVerification:")
    print(f"Total tables: {len(doc2.tables)}")
    for para in doc2.paragraphs:
        if "2.4" in para.text and para.style.name in ("Heading 2", "Heading 3"):
            print(f"  [{para.style.name}] {para.text}")
        if "Bảng 2.2" in para.text and para.style.name == "Bảng":
            print(f"  [{para.style.name}] {para.text}")
        if "Hình 2.6" in para.text:
            print(f"  [{para.style.name}] {para.text}")


if __name__ == "__main__":
    main()

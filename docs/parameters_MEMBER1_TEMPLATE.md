# Bảng tham số môi trường – Thành viên 1 xác nhận

**Trạng thái:** CHƯA XÁC MINH. `config.m` chỉ sử dụng bộ giá trị mẫu để thử chương trình.

| environment | a | b | eta_los_dB | eta_nlos_dB | Bài báo / bảng / trang | Dải tần áp dụng |
|---|---:|---:|---:|---:|---|---|
| urban | 9.61* | 0.16* | 1.0* | 20.0* | TODO | TODO |
| suburban | 4.88* | 0.43* | 0.1* | 21.0* | TODO | TODO |

`*` Giá trị tham khảo phổ biến trong mô hình Al-Hourani, cần xác nhận lại tại tài liệu gốc và tính phù hợp với 2.4 GHz của đề tài.

Việc cần làm:
1. Đối chiếu bài báo gốc và ghi trang/bảng/công thức cụ thể.
2. Xác định trường hợp giới hạn tần số và điều kiện môi trường.
3. Nếu nguồn áp dụng phù hợp hơn ở 2 GHz, đề xuất thay `cfg.f_Hz` và thông báo nhóm.
4. Khi đã rà soát, tạo `docs/parameters.md` chính thức; yêu cầu Thành viên 2 cập nhật `config.m` và `cfg.params_reviewed=true`.

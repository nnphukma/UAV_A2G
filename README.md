# UAV – Ground Station A2G | MATLAB | Thành viên 2

## 1. Mục tiêu
Mô phỏng kênh truyền Air-to-Ground theo chuỗi hình học -> FSPL ->
P(LoS) Al-Hourani -> Path Loss trung bình. Giữ đúng phạm vi tối giản 7 ngày.
Không cần Simulink, Communications Toolbox hoặc phần cứng.

## 2. Cách ghép với base project trên D:\
1. Sao lưu `config.py`, `main.py` và các file đang có; **không ghi đè nếu chứa công việc khác**.
2. Giải nén ZIP vào thư mục gốc của project. Các file MATLAB `.m` nằm
   cạnh các file Python `.py` cũ. MATLAB chỉ chạy `.m` trong lộ trình này.
3. Mở MATLAB, chọn **Current Folder** là thư mục gốc của project.
4. Gõ lệnh:

```matlab
main
```

5. Ba CSV sinh ra trong `results/csv/`:
   - `distance.csv` (201 dòng)
   - `altitude.csv` (201 dòng)
   - `environment.csv` (402 dòng)

6. Kiểm thử (không cần toolbox):

```matlab
addpath('tests');
run_tests
```

7. Vẽ hình (phần Thành viên 3; code tham khảo):

```matlab
addpath('simulations');
plot_results
```

PNG nằm trong `results/figures/`. Việc vẽ hình không làm thay đổi CSV.

## 3. Thông số mặc định trong config.m
- `f_Hz=2.4e9` (giả định khảo sát; chú ý điều kiện áp dụng tham số nguồn)
- `hg_m=1.5` m; `h_baseline_m=100` m; `r_baseline_m=500` m.
- Quét r từ 100 đến 3000 m; h từ 20 đến 300 m.
- Môi trường: `urban`, `suburban`.
- Bộ a,b,eta trong config chỉ là **PROVISIONAL** cho tới khi Thành viên 1
  xác minh tài liệu và phạm vi áp dụng. `main` hiện cảnh báo rõ điều này.

**Không đưa dữ liệu sang báo cáo chính thức trước khi duyệt tham số.**

## 4. Giao diện module

| Hàm .m | Đầu vào | Đầu ra |
|---|---|---|
| `slant_distance` | r_m, h_m, hg_m | d_m |
| `elevation_angle` | r_m, h_m, hg_m | theta_deg |
| `fspl_db` | f_Hz, d_m | fspl_dB |
| `los_probability` | theta_deg, a, b | p_los |
| `average_pathloss` | fspl_dB, p_los, eta_los_dB, eta_nlos_dB | pl_avg_dB |
| `received_power` | Ptx, Gtx, Grx, Ltx, Lrx, PL | Prx_dBm (tùy chọn) |

## 5. CSV thống nhất với Thành viên 3

`scenario,environment,f_Hz,h_m,hg_m,r_m,d_m,theta_deg,fspl_dB,p_los,pl_avg_dB`

`simulations/plot_results.m` chỉ đọc CSV, không tự tính lại kênh truyền.
Người 3 có thể chỉnh cách vẽ nhưng không đổi schema hoặc công thức.

## 6. Chú ý về mô hình
- `PL_avg` là suy hao **trung bình thống kê theo dB** trong mô hình này.
- Không mô phỏng tòa nhà cụ thể hoặc hiện tượng fading nhanh.
- Không suy luận phạm vi liên lạc cực đại nếu chưa có ngưỡng độ nhạy thu.
- MATLAB phải hỗ trợ `table`, `writetable`, `readtable`, `atan2d`.
  Khuyến nghị MATLAB R2018b trở lên.

## 7. Tình trạng kiểm chứng
Đã kiểm tra số học tham chiếu và cấu trúc file, nhưng **chưa chạy trực tiếp
trên MATLAB** trong môi trường tạo file. Hãy chạy `run_tests` trên máy nhóm
trước khi công bố kết quả mô phỏng.

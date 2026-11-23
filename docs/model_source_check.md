# ĐỐI CHIẾU CÔNG THỨC VÀ NGUỒN SỐ LIỆU

Nguồn do TV1 cung cấp: Bor-Yaliniz, El-Keyi, Yanikomeroglu (2018), IEEE Transactions on Wireless Communications, DOI 10.1109/TWC.2018.2874230, Table I.

| Environment | a | b | eta_LoS_dB | eta_NLoS_dB |
|---|---:|---:|---:|---:|
| Suburban | 4.88 | 0.43 | 0.1 | 21 |
| Urban | 9.61 | 0.16 | 1.0 | 20 |

Công thức dùng:
- d = sqrt(r^2 + (h-hg)^2), theta = atan2d(h-hg,r).
- FSPL = 20log10(4*pi*f*d/c).
- P_LoS = 1 / (1 + a*exp(-b*(theta-a))).
- PL_avg = P_LoS*(FSPL+eta_LoS) + (1-P_LoS)*(FSPL+eta_NLoS).

Một điểm cần nói rõ trong báo cáo: nguồn gốc mô hình là kênh A2G cho drone base station và người dùng mặt đất; nhóm kế thừa như một **mô hình thống kê minh họa** cho liên kết UAV–trạm mặt đất. Không phải mô phỏng vật cản theo bản đồ thật.

Tần số 2.4 GHz là đầu vào do nhóm lựa chọn, không phải kết quả đo kiểm tại tần số này. Các số 100 m, 1.5 m, 500 m cũng là giả định khảo sát.

import 'package:flutter/material.dart';

void main() {
  runApp(const WorkshopApp());
}

class WorkshopApp extends StatelessWidget {
  const WorkshopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workshop Kampus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0C447C)),
        useMaterial3: true,
      ),
      home: const WorkshopScreen(),
    );
  }
}

class Workshop {
  final String judul;
  final String tanggal;
  final String lokasi;
  final int kuota;
  final int terdaftar;
  final String kategori;

  const Workshop({
    required this.judul,
    required this.tanggal,
    required this.lokasi,
    required this.kuota,
    required this.terdaftar,
    required this.kategori,
  });

  bool get isFull => terdaftar >= kuota;
  double get sisaKuota => terdaftar / kuota;
}

class WorkshopScreen extends StatefulWidget {
  const WorkshopScreen({super.key});

  @override
  State<WorkshopScreen> createState() => _WorkshopScreenState();
}

class _WorkshopScreenState extends State<WorkshopScreen> {
  // Pindahin daftar data ke dalam State
  final List<Workshop> listData = [
    const Workshop(
      judul: 'UI/UX Design dengan Figma',
      tanggal: 'Senin, 12 Mei 2025',
      lokasi: 'Aula Teknik, Lt. 2',
      kuota: 40,
      terdaftar: 26,
      kategori: 'Teknologi',
    ),
    const Workshop(
      judul: 'Public Speaking Efektif',
      tanggal: 'Rabu, 14 Mei 2025',
      lokasi: 'Ruang Seminar B',
      kuota: 40,
      terdaftar: 40,
      kategori: 'Bisnis',
    ),
    const Workshop(
      judul: 'Pemrograman Flutter Dasar',
      tanggal: 'Jumat, 16 Mei 2025',
      lokasi: 'Lab Komputer 3',
      kuota: 30,
      terdaftar: 12,
      kategori: 'Teknologi',
    ),
    const Workshop(
      judul: 'Kewirausahaan Digital',
      tanggal: 'Sabtu, 17 Mei 2025',
      lokasi: 'Aula Utama',
      kuota: 60,
      terdaftar: 45,
      kategori: 'Bisnis',
    ),
  ];

  void prosesDaftar(int index) {
    setState(() {
      final w = listData[index];
      if (w.terdaftar < w.kuota) {
        listData[index] = Workshop(
          judul: w.judul,
          tanggal: w.tanggal,
          lokasi: w.lokasi,
          kuota: w.kuota,
          terdaftar: w.terdaftar + 1,
          kategori: w.kategori,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Berhasil mendaftar: ${w.judul}'),
            backgroundColor: const Color(0xFF0C447C),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C447C),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Workshop Kampus',
              style: TextStyle(
                color: Color(0xFFB5D4F4),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Temukan workshop untukmu',
              style: TextStyle(color: Color(0xFF85B7EB), fontSize: 12),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: const Color(0xFF185FA5),
              radius: 18,
              child: const Text(
                'A',
                style: TextStyle(
                  color: Color(0xFFB5D4F4),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari workshop...',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                prefixIcon: const Icon(Icons.search, size: 20),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              'Workshop tersedia',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              itemCount: listData.length,
              itemBuilder: (context, index) {
                // Lempar fungsi prosesDaftar ke WorkshopCard
                return WorkshopCard(
                  workshop: listData[index],
                  onDaftar: () => prosesDaftar(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WorkshopCard extends StatelessWidget {
  final Workshop workshop;
  final VoidCallback onDaftar; // Callback buat tombol

  const WorkshopCard({
    super.key,
    required this.workshop,
    required this.onDaftar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFFE6F1FB),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                workshop.kategori,
                style: const TextStyle(
                  color: Color(0xFF0C447C),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              workshop.judul,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 14,
                  color: Colors.grey.shade500,
                ),
                const SizedBox(width: 6),
                Text(
                  workshop.tanggal,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 14,
                  color: Colors.grey.shade500,
                ),
                const SizedBox(width: 6),
                Text(
                  workshop.lokasi,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kuota: ${workshop.terdaftar} / ${workshop.kuota}',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                Text(
                  workshop.isFull ? 'Penuh' : 'Tersedia',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: workshop.isFull
                        ? const Color(0xFFA32D2D)
                        : const Color(0xFF0C447C),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: workshop.sisaKuota,
                minHeight: 6,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(
                  workshop.isFull
                      ? const Color(0xFFE24B4A)
                      : const Color(0xFF0C447C),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Divider(height: 1, color: Colors.grey.shade100),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: workshop.isFull ? null : onDaftar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0C447C),
                  disabledBackgroundColor: Colors.grey.shade200,
                  foregroundColor: Colors.white,
                  disabledForegroundColor: Colors.grey.shade400,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  workshop.isFull ? 'Kuota penuh' : 'Daftar sekarang',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// KLE Society's BCA GH College, Haveri — Flutter Web
// ----------------------------------------------------------------------------
// A single-file Flutter app you can run as a website with:
//     flutter create kle_bca_haveri
//     (replace lib/main.dart with this file, then)
//     flutter run -d chrome
//
// No external packages required — pure Flutter/Material.
//
// Content is drawn from the college's public information (klebcahaveri.com
// and affiliated listings): established 2007, affiliated to Karnatak
// University Dharwad, address, facilities, programme structure, etc.
// Please double-check phone numbers/emails/fee figures with the college
// directly before publishing, since these can change year to year.
// ============================================================================

import 'package:flutter/material.dart';

void main() => runApp(const KleBcaApp());

// ---------------------------------------------------------------------------
// Design tokens
// ---------------------------------------------------------------------------
class Palette {
  static const navy = Color(0xFF14273F); // Ink Navy — hero, nav, footer
  static const navyDeep = Color(0xFF0D1B2E);
  static const chalk = Color(0xFFEFECE1); // Chalk White — main background
  static const paper = Color(0xFFFAF8F2); // card surfaces
  static const marigold = Color(0xFFE2A33B); // Marigold — accent / signature
  static const marigoldDeep = Color(0xFFC2801F);
  static const banyan = Color(0xFF2C5233); // Banyan Green — placements band
  static const ink = Color(0xFF1B1B18); // primary text
  static const inkSoft = Color(0xFF4A493F); // secondary text
  static const rule = Color(0xFFD8D2BF); // hairline dividers
}

TextStyle display({double size = 40, Color color = Palette.ink, FontWeight w = FontWeight.w700, double? height}) {
  return TextStyle(
    fontFamily: 'Georgia',
    fontFamilyFallback: const ['serif'],
    fontSize: size,
    fontWeight: w,
    color: color,
    height: height ?? 1.08,
    letterSpacing: -0.3,
  );
}

TextStyle mono({double size = 13, Color color = Palette.inkSoft, FontWeight w = FontWeight.w500, double spacing = 1.6}) {
  return TextStyle(
    fontFamily: 'Courier',
    fontFamilyFallback: const ['monospace'],
    fontSize: size,
    fontWeight: w,
    color: color,
    letterSpacing: spacing,
  );
}

TextStyle body({double size = 16, Color color = Palette.inkSoft, FontWeight w = FontWeight.w400, double height = 1.55}) {
  return TextStyle(fontSize: size, fontWeight: w, color: color, height: height);
}

// ---------------------------------------------------------------------------
// App shell
// ---------------------------------------------------------------------------
class KleBcaApp extends StatelessWidget {
  const KleBcaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "KLE Society's BCA GH College, Haveri",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Palette.chalk,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Palette.navy),
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: WidgetStateProperty.all(Palette.marigold.withValues(alpha: 0.6)),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final _aboutKey = GlobalKey();
  final _programmeKey = GlobalKey();
  final _facilitiesKey = GlobalKey();
  final _placementKey = GlobalKey();
  final _contactKey = GlobalKey();

  void _goTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Hero(
                  onExplore: () => _goTo(_programmeKey),
                  onVisit: () => _goTo(_contactKey),
                ),
                _About(key: _aboutKey),
                const _VisionMissionObjectives(),
                _Programme(key: _programmeKey),
                _Facilities(key: _facilitiesKey),
                _Placements(key: _placementKey),
                _Contact(key: _contactKey),
                const _Footer(),
              ],
            ),
          ),
          _TopNav(
            wide: wide,
            onAbout: () => _goTo(_aboutKey),
            onProgramme: () => _goTo(_programmeKey),
            onFacilities: () => _goTo(_facilitiesKey),
            onPlacement: () => _goTo(_placementKey),
            onContact: () => _goTo(_contactKey),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Signature element: a "terminal bar" strip — three dots + a file-tab label.
// Used sparingly (nav + hero + footer) as the one recurring motif that ties
// the visual language back to "Computer Applications".
// ---------------------------------------------------------------------------
class _TerminalTab extends StatelessWidget {
  final String label;
  final Color color;
  const _TerminalTab({required this.label, this.color = Palette.marigold});

  @override
  Widget build(BuildContext context) {
    Widget dot(Color c) => Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(right: 6),
          decoration: BoxDecoration(color: c, shape: BoxShape.circle),
        );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        dot(const Color(0xFFE2604E)),
        dot(const Color(0xFFE2B23F)),
        dot(const Color(0xFF5FAE73)),
        const SizedBox(width: 10),
        Text(label, style: mono(size: 12.5, color: color, spacing: 1.2)),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Top navigation
// ---------------------------------------------------------------------------
class _TopNav extends StatelessWidget {
  final bool wide;
  final VoidCallback onAbout, onProgramme, onFacilities, onPlacement, onContact;
  const _TopNav({
    required this.wide,
    required this.onAbout,
    required this.onProgramme,
    required this.onFacilities,
    required this.onPlacement,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    Widget link(String text, VoidCallback onTap) => TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(foregroundColor: Palette.chalk),
          child: Text(text, style: mono(size: 12.5, color: Palette.chalk, spacing: 1.2)),
        );

    return Container(
      height: 64,
      color: Palette.navy.withValues(alpha: 0.96),
      padding: EdgeInsets.symmetric(horizontal: wide ? 40 : 16),
      child: Row(
        children: [
          const Icon(Icons.school, color: Palette.marigold, size: 20),
          const SizedBox(width: 10),
          Text(
            "KLE · GH BCA COLLEGE",
            style: mono(size: 13, color: Palette.chalk, spacing: 1.4, w: FontWeight.w700),
          ),
          const Spacer(),
          if (wide) ...[
            link('ABOUT', onAbout),
            link('PROGRAMME', onProgramme),
            link('FACILITIES', onFacilities),
            link('PLACEMENTS', onPlacement),
            link('CONTACT', onContact),
          ] else
            IconButton(
              icon: const Icon(Icons.menu, color: Palette.chalk),
              onPressed: onContact,
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Hero
// ---------------------------------------------------------------------------
class _Hero extends StatelessWidget {
  final VoidCallback onExplore, onVisit;
  const _Hero({required this.onExplore, required this.onVisit});

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width >= 900;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(wide ? 40 : 20, 140, wide ? 40 : 20, 80),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Palette.navy, Palette.navyDeep],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _TerminalTab(label: '// EST. 2007 · AFFILIATED TO KARNATAK UNIVERSITY, DHARWAD'),
          const SizedBox(height: 28),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: wide ? 820 : double.infinity),
            child: Text(
              "Where Haveri's\nyoung minds learn\nto write the code.",
              style: display(size: wide ? 58 : 36, color: Palette.chalk, height: 1.05),
            ),
          ),
          const SizedBox(height: 24),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Text(
              "KLE Society's College of Bachelor of Computer Applications sits on the "
              "GH College campus in Haveri, Karnataka — a three-year, NEP-aligned "
              "programme built on the same discipline and care the wider KLE Society "
              "has carried since its founding in Belagavi.",
              style: body(size: 16.5, color: Palette.chalk.withValues(alpha: 0.82)),
            ),
          ),
          const SizedBox(height: 36),
          Wrap(
            spacing: 16,
            runSpacing: 12,
            children: [
              _GhostButton(label: 'Explore the BCA programme', onTap: onExplore, filled: true),
              _GhostButton(label: 'Visit the campus', onTap: onVisit, filled: false),
            ],
          ),
        ],
      ),
    );
  }
}

class _GhostButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool filled;
  const _GhostButton({required this.label, required this.onTap, required this.filled});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(2),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        decoration: BoxDecoration(
          color: filled ? Palette.marigold : Colors.transparent,
          border: Border.all(color: Palette.marigold, width: 1.4),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Text(
          label,
          style: mono(
            size: 12.5,
            spacing: 1.1,
            w: FontWeight.w700,
            color: filled ? Palette.navyDeep : Palette.marigold,
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared section wrapper
// ---------------------------------------------------------------------------
class _Section extends StatelessWidget {
  final String eyebrow;
  final String title;
  final Widget child;
  final Color background;
  final Color eyebrowColor;
  final Color titleColor;
  const _Section({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.child,
    this.background = Palette.chalk,
    this.eyebrowColor = Palette.marigoldDeep,
    this.titleColor = Palette.ink,
  });

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width >= 900;
    return Container(
      width: double.infinity,
      color: background,
      padding: EdgeInsets.symmetric(horizontal: wide ? 40 : 20, vertical: wide ? 88 : 56),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('// $eyebrow', style: mono(size: 12.5, color: eyebrowColor, w: FontWeight.w700)),
          const SizedBox(height: 12),
          Text(title, style: display(size: wide ? 34 : 26, color: titleColor)),
          const SizedBox(height: 32),
          child,
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// About
// ---------------------------------------------------------------------------
class _About extends StatelessWidget {
  const _About({super.key});

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width >= 900;
    final text = Expanded(
      flex: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "KLE Society's BCA College was founded in 2007 on the campus of GH College, "
            "Haveri, and has grown into a close-knit department known for staff who stay "
            "invested in every student's progress, not just their marks. The college is "
            "affiliated to Karnatak University, Dharwad, and follows the NEP-aligned BCA "
            "curriculum across all six semesters.",
            style: body(size: 16.5),
          ),
          const SizedBox(height: 18),
          Text(
            "It is run under the umbrella of KLE Society, one of Karnataka's long-standing "
            "education trusts, headquartered in Belagavi, which operates a wide network of "
            "schools and colleges across the state. Being part of that network gives the "
            "Haveri BCA college shared academic standards while keeping its own local, "
            "hands-on character.",
            style: body(size: 16.5),
          ),
          const SizedBox(height: 26),
          Row(
            children: [
              Expanded(child: _StatBlock(value: '2007', label: 'Year founded')),
              Expanded(child: _StatBlock(value: '6', label: 'Semesters, NEP-aligned')),
              Expanded(child: _StatBlock(value: 'KUD', label: 'Affiliated university')),
            ],
          ),
        ],
      ),
    );

    final graphic = Expanded(
      flex: 5,
      child: _CodeWindowGraphic(),
    );

    return _Section(
      eyebrow: 'ABOUT THE COLLEGE',
      title: 'A small department with\na focused purpose',
      child: wide
          ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [text, const SizedBox(width: 48), graphic])
          : Column(children: [text, const SizedBox(height: 32), graphic]),
    );
  }
}

class _StatBlock extends StatelessWidget {
  final String value;
  final String label;
  const _StatBlock({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: display(size: 26, color: Palette.navy)),
          const SizedBox(height: 4),
          Text(label.toUpperCase(), style: mono(size: 10.5, spacing: 1.0)),
        ],
      ),
    );
  }
}

/// Decorative stand-in for a campus photo: a stylised "code editor" window
/// echoing the terminal-tab signature, reinforcing "Computer Applications"
/// without relying on stock imagery.
class _CodeWindowGraphic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lines = <double>[0.9, 0.55, 0.72, 0.4, 0.85, 0.3, 0.6];
    return Container(
      decoration: BoxDecoration(
        color: Palette.navy,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 24, offset: const Offset(0, 12))],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _TerminalTab(label: 'bca_haveri.dart'),
          const SizedBox(height: 20),
          ...List.generate(lines.length, (i) {
            final w = lines[i];
            final colors = [Palette.marigold, Palette.chalk.withValues(alpha: 0.5), const Color(0xFF5FAE73)];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: w,
                child: Container(height: 9, decoration: BoxDecoration(color: colors[i % colors.length].withValues(alpha: 0.75), borderRadius: BorderRadius.circular(2))),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Vision / Mission / Objectives
// ---------------------------------------------------------------------------
class _VisionMissionObjectives extends StatelessWidget {
  const _VisionMissionObjectives();

  @override
  Widget build(BuildContext context) {
    final cards = [
      _VmoCard(
        tag: 'VISION',
        text: 'To become a source of enlightenment and empowerment for the seekers of knowledge.',
      ),
      _VmoCard(
        tag: 'MISSION',
        text: 'To help students grow into socially responsible, productive and useful citizens of a globalised world.',
      ),
      _VmoCard(
        tag: 'OBJECTIVE',
        text: 'To draw young minds into a rich, employable field, and to build a strong foundation for further study in computer applications.',
      ),
    ];

    return _Section(
      eyebrow: 'WHY THE COLLEGE EXISTS',
      title: 'Vision, mission,\nand objective',
      background: Palette.paper,
      child: LayoutBuilder(builder: (context, c) {
        final wide = c.maxWidth >= 900;
        if (wide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: cards
                .map((w) => Expanded(child: Padding(padding: const EdgeInsets.only(right: 20), child: w)))
                .toList(),
          );
        }
        return Column(children: cards.map((w) => Padding(padding: const EdgeInsets.only(bottom: 20), child: w)).toList());
      }),
    );
  }
}

class _VmoCard extends StatelessWidget {
  final String tag;
  final String text;
  const _VmoCard({required this.tag, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Palette.chalk,
        border: Border(top: BorderSide(color: Palette.marigold, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(tag, style: mono(size: 11.5, color: Palette.marigoldDeep, w: FontWeight.w700, spacing: 1.4)),
          const SizedBox(height: 14),
          Text(text, style: body(size: 15.5)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Programme — BCA semester timeline (a genuine sequence, so numbering earns
// its place here)
// ---------------------------------------------------------------------------
class _Programme extends StatelessWidget {
  const _Programme({super.key});

  @override
  Widget build(BuildContext context) {
    final semesters = [
      ('I–II', 'Foundations', 'Programming fundamentals, mathematics and communicative English, alongside a 1st-semester UI/UX design project.'),
      ('III–IV', 'Applied development', 'Data structures, databases and web technologies, including a 3rd-semester MERN-stack project.'),
      ('V–VI', 'Specialisation', 'Advanced electives and a capstone body of work, including a 5th-semester artificial intelligence project.'),
    ];

    return _Section(
      eyebrow: 'THE PROGRAMME',
      title: 'Bachelor of Computer\nApplications — 3 years, 6 semesters',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'The BCA is a full-time, three-year undergraduate degree affiliated to Karnatak '
            'University, Dharwad, and taught under the NEP syllabus. Coursework runs through '
            'six semesters, with student project work growing in depth each year.',
            style: body(size: 16),
          ),
          const SizedBox(height: 32),
          LayoutBuilder(builder: (context, c) {
            final wide = c.maxWidth >= 900;
            final items = semesters
                .asMap()
                .entries
                .map((e) => _SemesterCard(index: e.key + 1, range: e.value.$1, title: e.value.$2, text: e.value.$3))
                .toList();
            if (wide) {
              return Row(children: items.map((w) => Expanded(child: Padding(padding: const EdgeInsets.only(right: 18), child: w))).toList());
            }
            return Column(children: items.map((w) => Padding(padding: const EdgeInsets.only(bottom: 18), child: w)).toList());
          }),
        ],
      ),
    );
  }
}

class _SemesterCard extends StatelessWidget {
  final int index;
  final String range;
  final String title;
  final String text;
  const _SemesterCard({required this.index, required this.range, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(color: Palette.paper, borderRadius: BorderRadius.circular(4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('0$index', style: display(size: 30, color: Palette.marigoldDeep)),
          const SizedBox(height: 4),
          Text('SEM $range', style: mono(size: 11, spacing: 1.2)),
          const SizedBox(height: 12),
          Text(title, style: display(size: 18, color: Palette.ink)),
          const SizedBox(height: 10),
          Text(text, style: body(size: 14)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Facilities
// ---------------------------------------------------------------------------
class _Facilities extends StatelessWidget {
  const _Facilities({super.key});

  static const items = [
    (Icons.menu_book, 'Library', 'A dedicated reading and reference space for BCA coursework.'),
    (Icons.other_houses, "Ladies' hostel", 'On-campus residential facility for women students.'),
    (Icons.pool, 'Swimming pool', 'Campus recreation facility open to students.'),
    (Icons.fitness_center, 'Multi-gym for boys', 'A dedicated fitness space for male students.'),
    (Icons.restaurant, 'Canteen', 'On-campus dining for students and staff.'),
    (Icons.sports_basketball, 'Indoor stadium', 'Covered space for indoor sport and events.'),
    (Icons.sports_soccer, 'Playground', 'Open grounds for outdoor sport.'),
    (Icons.record_voice_over, 'Language lab', 'Spoken-English practice for communication skills.'),
  ];

  @override
  Widget build(BuildContext context) {
    return _Section(
      eyebrow: 'ON CAMPUS',
      title: 'Facilities',
      background: Palette.navy,
      eyebrowColor: Palette.marigold,
      titleColor: Palette.chalk,
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: items
            .map((f) => _FacilityChip(icon: f.$1, title: f.$2, text: f.$3))
            .toList(),
      ),
    );
  }
}

class _FacilityChip extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  const _FacilityChip({required this.icon, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Palette.marigold, size: 22),
          const SizedBox(height: 12),
          Text(title, style: display(size: 16, color: Palette.chalk)),
          const SizedBox(height: 6),
          Text(text, style: body(size: 13, color: Palette.chalk.withValues(alpha: 0.7), height: 1.4)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Placements & Toppers — presented as a ledger, since it's genuinely a
// record of years
// ---------------------------------------------------------------------------
class _Placements extends StatelessWidget {
  const _Placements({super.key});

  static const years = ['2025–26', '2024–25', '2023–24', '2021–22', '2020–21'];
  static const topperYears = ['2025–26', '2022–23', '2021–22', '2020–21', '2019–20'];

  @override
  Widget build(BuildContext context) {
    return _Section(
      eyebrow: 'TRACK RECORD',
      title: 'Placements & toppers,\nyear on year',
      background: Palette.banyan,
      eyebrowColor: Palette.marigold,
      titleColor: Palette.chalk,
      child: LayoutBuilder(builder: (context, c) {
        final wide = c.maxWidth >= 900;
        final ledgers = [
          _Ledger(title: 'Placement records on file', rows: years),
          _Ledger(title: 'Topper records on file', rows: topperYears),
        ];
        if (wide) {
          return Row(children: ledgers.map((w) => Expanded(child: Padding(padding: const EdgeInsets.only(right: 24), child: w))).toList());
        }
        return Column(children: ledgers.map((w) => Padding(padding: const EdgeInsets.only(bottom: 24), child: w)).toList());
      }),
    );
  }
}

class _Ledger extends StatelessWidget {
  final String title;
  final List<String> rows;
  const _Ledger({required this.title, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: mono(size: 12, color: Palette.marigold, w: FontWeight.w700, spacing: 1.1)),
          const SizedBox(height: 16),
          ...rows.map((y) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: Row(
                  children: [
                    Expanded(child: Text(y, style: mono(size: 13.5, color: Palette.chalk))),
                    Icon(Icons.chevron_right, size: 16, color: Palette.chalk.withValues(alpha: 0.5)),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Contact
// ---------------------------------------------------------------------------
class _Contact extends StatelessWidget {
  const _Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return _Section(
      eyebrow: 'FIND US',
      title: 'Contact & location',
      background: Palette.paper,
      child: LayoutBuilder(builder: (context, c) {
        final wide = c.maxWidth >= 900;
        final details = Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ContactLine(icon: Icons.account_balance, label: 'Institution', value: "KLE Society's College of Bachelor of Computer Applications"),
              _ContactLine(icon: Icons.place, label: 'Address', value: 'PB Road, GH College Campus, Haveri – 581110, Karnataka, India'),
              _ContactLine(icon: Icons.call, label: 'Phone', value: '08375-232475'),
              _ContactLine(icon: Icons.account_balance_outlined, label: 'Affiliated to', value: 'Karnatak University, Dharwad'),
            ],
          ),
        );
        final map = Expanded(
          flex: 4,
          child: Container(
            height: 220,
            decoration: BoxDecoration(color: Palette.navy, borderRadius: BorderRadius.circular(4)),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _TerminalTab(label: 'location.dart'),
                const Spacer(),
                Text('HAVERI, KARNATAKA', style: mono(size: 13, color: Palette.chalk, w: FontWeight.w700, spacing: 1.4)),
                const SizedBox(height: 6),
                Text('Nearest railway station: Haveri', style: body(size: 12.5, color: Palette.chalk.withValues(alpha: 0.7))),
                Text('Nearest airport: Hubballi (~68 km)', style: body(size: 12.5, color: Palette.chalk.withValues(alpha: 0.7))),
              ],
            ),
          ),
        );
        if (wide) {
          return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [details, const SizedBox(width: 32), map]);
        }
        return Column(children: [details, const SizedBox(height: 24), map]);
      }),
    );
  }
}

class _ContactLine extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _ContactLine({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Palette.marigoldDeep),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label.toUpperCase(), style: mono(size: 10.5, spacing: 1.2)),
                const SizedBox(height: 3),
                Text(value, style: display(size: 16, color: Palette.ink, w: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Footer
// ---------------------------------------------------------------------------
class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width >= 900;
    return Container(
      width: double.infinity,
      color: Palette.navyDeep,
      padding: EdgeInsets.symmetric(horizontal: wide ? 40 : 20, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _TerminalTab(label: 'bca_haveri.dart — end of file'),
          const SizedBox(height: 20),
          Text(
            "© ${DateTime.now().year} KLE Society's College of Bachelor of Computer Applications, Haveri.",
            style: body(size: 12.5, color: Palette.chalk.withValues(alpha: 0.6)),
          ),
          const SizedBox(height: 6),
          Text(
            'A constituent programme run under KLE Society, Belagavi, on the GH College campus.',
            style: body(size: 12.5, color: Palette.chalk.withValues(alpha: 0.45)),
          ),
        ],
      ),
    );
  }
}
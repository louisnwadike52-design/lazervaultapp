part of 'business_dashboard_screen.dart';

class _Kpi {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  _Kpi(this.label, this.value, this.icon, this.color);
}

class _Bar {
  final String label;
  final double value;
  final Color color;
  _Bar(this.label, this.value, this.color);
}

class _Action {
  final String label;
  final IconData icon;
  final String route;
  _Action(this.label, this.icon, this.route);
}

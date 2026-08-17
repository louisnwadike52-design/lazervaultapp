part of 'create_lock_carousel.dart';

/// A single wizard page: hosts one or more of the step widgets inside
/// a shared scroll view. The step widgets themselves are non-scrolling
/// (they return a padded Column), so grouping two per page here is what
/// collapses the original five slides into three without dropping any
/// captured field or nesting scroll views.
class _WizardPage extends StatelessWidget {
  final List<Widget> children;

  const _WizardPage({required this.children});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

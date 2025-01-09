part of '../pages/sign_in_page.dart';

final class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    required this.onPressed,
    required this.isLoading,
    required this.label,
  });

  final VoidCallback? onPressed;
  final bool isLoading;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.buttonHeight.h,
      child: ElevatedButton(
        onPressed: onPressed,
        child: isLoading
            ? const SizedBox.square(
                dimension: Dimensions.lg,
                child: CircularProgressIndicator(),
              )
            : Text(label),
      ),
    );
  }
}

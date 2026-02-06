import 'package:auric/theme/colors.dart';
import 'package:flutter/material.dart';

class AuricTypography {
	static const headline1 = TextStyle(
		fontSize: 32,
		fontWeight: FontWeight.bold,
		letterSpacing: 0.5,
		color: AuricColors.primary,
	);
	static const headline2 = TextStyle(
		fontSize: 24,
		fontWeight: FontWeight.w600,
		color: AuricColors.accent,
	);
	static const title = TextStyle(
		fontSize: 20,
		fontWeight: FontWeight.w500,
		color: AuricColors.secondary,
	);
	static const body = TextStyle(
		fontSize: 16,
		fontWeight: FontWeight.normal,
		color: AuricColors.secondary,
	);
	static const caption = TextStyle(
		fontSize: 12,
		color: AuricColors.secondary,
	);
}

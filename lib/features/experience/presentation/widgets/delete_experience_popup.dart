import 'package:flutter/material.dart';
import 'package:fullcycle/services/navigation/navigation.dart';

import '../../../candidate/data/repository/candidate_repository.dart';

void showDeleteExperienceDialog(id) {
  showDialog(
    context: AppNavigation.context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        contentPadding: const EdgeInsets.all(16),
        title: const Text(
          "هل أنت متأكد من حذف هذه الخبرة؟",
          textAlign: TextAlign.right,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        content: const Text(
          "سيتم إزالة هذه الخبرة من ملفك الشخصي ولن تتمكن من استعادتها لاحقاً. هل ترغب بمتابعة الحذف؟",
          textAlign: TextAlign.right,
        ),
        actionsAlignment: MainAxisAlignment.end,
        actions: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.grey),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text(
              "الغاء",
              style: TextStyle(color: Colors.black),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffD92D20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onPressed: () {
              Repo.deleteExperience(id);
            },
            child: const Text(
              "مسح",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}

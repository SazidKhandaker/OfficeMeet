import 'package:flutter/material.dart';

void showPremiumSnackBar({

  required BuildContext context,

  required String message,

  required Color color,

  required IconData icon,
}) {

  ScaffoldMessenger.of(
    context,
  ).hideCurrentSnackBar();

  ScaffoldMessenger.of(
    context,
  ).showSnackBar(

    SnackBar(

      behavior:
      SnackBarBehavior.floating,

      backgroundColor:
      Colors.transparent,

      elevation: 0,

      margin:
      const EdgeInsets.all(
        16,
      ),

      duration:
      const Duration(
        seconds: 3,
      ),

      content: Container(

        padding:
        const EdgeInsets.symmetric(

          horizontal: 18,
          vertical: 16,
        ),

        decoration:
        BoxDecoration(

          borderRadius:
          BorderRadius.circular(
            22,
          ),

          gradient:
          LinearGradient(

            colors: [

              color.withOpacity(
                0.85,
              ),

              const Color(
                0xFF151025,
              ),
            ],
          ),

          border:
          Border.all(

            color:
            color.withOpacity(
              0.4,
            ),
          ),

          boxShadow: [

            BoxShadow(

              color:
              color.withOpacity(
                0.30,
              ),

              blurRadius: 18,
            ),
          ],
        ),

        child: Row(

          children: [

            Container(

              padding:
              const EdgeInsets.all(
                10,
              ),

              decoration:
              BoxDecoration(

                shape:
                BoxShape.circle,

                color:
                Colors.white
                    .withOpacity(
                  0.12,
                ),
              ),

              child: Icon(

                icon,

                color:
                Colors.white,

                size: 22,
              ),
            ),

            const SizedBox(
              width: 14,
            ),

            Expanded(

              child: Text(

                message,

                style:
                const TextStyle(

                  color:
                  Colors.white,

                  fontWeight:
                  FontWeight.w600,

                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
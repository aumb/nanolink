import 'package:celest_backend/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nanolink/app/widgets/toastification.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class LinkCard extends StatelessWidget {
  const LinkCard({
    required this.link,
    super.key,
  });

  final Link link;

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      title: Text(link.originalUrl),
      description: InkWell(
        onTap: () {
          Clipboard.setData(
            ClipboardData(text: link.shortenedUrl),
          );
          showCopyToast(context, link.shortenedUrl);
        },
        child: Text(link.shortenedUrl),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisSize: MediaQuery.sizeOf(context).width < 600
                ? MainAxisSize.max
                : MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  Clipboard.setData(
                    const ClipboardData(text: '2222222222223'),
                  );
                  showCopyToast(context, '222233');
                },
                child: Column(
                  children: [
                    const Icon(Icons.ads_click),
                    Text(
                      '2222222222223',
                      style: ShadTheme.of(context).textTheme.muted,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            DateFormat.yMMMEd().format(link.createAt),
            style: ShadTheme.of(context).textTheme.muted,
          ),
        ],
      ),
    );
  }
}

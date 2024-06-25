import 'package:flutter/material.dart';
import 'package:ostadi_frontend/core/utilities/dateHelper.dart';
import 'package:ostadi_frontend/features/posts/domain/entities/post.dart';


class PostWidget extends StatelessWidget {
  final Post post;
  bool showForEditting;
  Function? onApply;
  String? actionButtonText;
  PostWidget({super.key, required this.post,this.onApply,this.actionButtonText,this.showForEditting=false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Text(
                'Posted on ${DateHelper.dateTimeToString(DateTime.parse(post.date))}',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              Spacer(),
               showForEditting ? const PrimaryIconBtn(icon: Icons.remove_red_eye_outlined):ElevatedButton(onPressed: (){ onApply?.call();}, child: Text(actionButtonText!,style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Theme.of(context).colorScheme.onPrimary),), style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary ),),
              if(showForEditting) const PrimaryIconBtn(icon: Icons.edit),
            ],
          ),
        ),
        Text(
          post.title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        ),
        Text(
          post.description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Proposals : ${post.proposalCount}',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  Text(
                    'Hired     : ${post.hiredCount}',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              ),
               if (showForEditting) Icon(
                Icons.delete_forever_outlined,
                color: Theme.of(context).colorScheme.tertiary,
              ) 
            ],
          ),
        ),
        Row(
          children: post.subjects
              .map((subject) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Chip(
                      side: BorderSide.none,
                      labelPadding: EdgeInsets.all(0),
                      label: Text(subject,style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant ),),
                      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                    ),
                  ))
              .toList(),
        )
      ]),
    );
  }
}

class PrimaryIconBtn extends StatelessWidget {
  final IconData icon;
  const PrimaryIconBtn({required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      color: Theme.of(context).colorScheme.primary,
      onPressed: () {},
    );
  }
}
import 'package:awesome_app/core/di/injection.dart';
import 'package:awesome_app/features/gallery/presentation/bloc/gallery_detail/gallery_detail_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

class GalleryDetailPage extends StatelessWidget {
  final int id;

  const GalleryDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GalleryDetailBloc>(
          create: (_) => GalleryDetailBloc(getImageDetailUc: injector.get())
            ..add(GalleryDetailEvent.GetGalleryDetail(id)),
        ),
      ],
      child: _GalleryLayout(id),
    );
  }
}

class _GalleryLayout extends StatelessWidget {
  final int id;
  const _GalleryLayout(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GalleryDetailBloc, GalleryDetailState>(
        builder: (_, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (statusCode, message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("$statusCode: $message"),
                  const SizedBox(height: 16),
                  TextButton.icon(
                    icon: const Icon(Icons.refresh),
                    label: const Text("Refresh"),
                    onPressed: () {
                      context
                          .read<GalleryDetailBloc>()
                          .add(GalleryDetailEvent.GetGalleryDetail(id));
                    },
                  ),
                ],
              ),
            ),
            success: (data) {
              return SafeArea(
                child: SmartRefresher(
                  controller:
                      context.read<GalleryDetailBloc>().refreshController,
                  enablePullDown: true,
                  onRefresh: () {
                    context
                        .read<GalleryDetailBloc>()
                        .add(GalleryDetailEvent.GetGalleryDetail(id));
                  },
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: CachedNetworkImage(
                                width: double.infinity,
                                height: 320,
                                imageUrl: data.src?.large2X ?? "",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              right: 8,
                              bottom: 8,
                              child: MaterialButton(
                                color: Colors.white,
                                shape: const StadiumBorder(),
                                onPressed: () {
                                  launchUrl(
                                    Uri.parse(data.url ?? ""),
                                    mode: LaunchMode.externalApplication,
                                  );
                                },
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.open_in_new,
                                      size: 20,
                                    ),
                                    Text("See Photo")
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        if (data.alt?.isNotEmpty ?? false) ...[
                          Text(
                            data.alt ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 16),
                        ],
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Photographer",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade500,
                                  ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    data.photographer ?? "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                                TextButton.icon(
                                  onPressed: () {
                                    launchUrl(
                                      Uri.parse(data.photographerUrl ?? ""),
                                      mode: LaunchMode.externalApplication,
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.open_in_new,
                                    size: 20,
                                  ),
                                  label: const Text(
                                    "See Profile",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Average Color",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade500,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Color(int.parse(
                                            (data.avgColor ?? "#FFFFFF")
                                                .substring(1, 7),
                                            radix: 16) +
                                        0xFF000000)
                                    .withOpacity(0.20),
                                borderRadius: BorderRadius.circular(360),
                              ),
                              child: Text(
                                data.avgColor ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Color(int.parse(
                                              (data.avgColor ?? "#FFFFFF")
                                                  .substring(1, 7),
                                              radix: 16) +
                                          0xFF000000),
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            orElse: () => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("No data"),
                  const SizedBox(height: 16),
                  TextButton.icon(
                    icon: const Icon(Icons.refresh),
                    label: const Text("Refresh"),
                    onPressed: () {
                      context
                          .read<GalleryDetailBloc>()
                          .add(GalleryDetailEvent.GetGalleryDetail(id));
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:awesome_app/core/constant/base_constant.dart';
import 'package:awesome_app/core/constant/gallery_constant.dart';
import 'package:awesome_app/core/di/injection.dart';
import 'package:awesome_app/features/gallery/domain/repository/gallery_repository.dart';
import 'package:awesome_app/features/gallery/domain/usecase/get_images_uc.dart';
import 'package:awesome_app/features/gallery/gallery_route.dart';
import 'package:awesome_app/features/gallery/presentation/bloc/images/images_bloc.dart';
import 'package:awesome_app/features/gallery/presentation/widgets/gallery_grid_view.dart';
import 'package:awesome_app/features/gallery/presentation/widgets/gallery_list_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ImagesBloc>(
          create: (_) => ImagesBloc(
            getImagesUc: GetImagesUc(injector.get<GalleryRepository>()),
          )..add(const ImagesEvent.GetImages()),
        ),
      ],
      child: const _GalleryLayout(),
    );
  }
}

class _GalleryLayout extends StatelessWidget {
  const _GalleryLayout();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: 144,
              centerTitle: true,
              backgroundColor: Theme.of(context).colorScheme.surface,
              surfaceTintColor: Theme.of(context).colorScheme.surface,
              shape: Border(
                bottom: BorderSide(
                  color: Colors.grey.withOpacity(0.25),
                ),
              ),
              actions: [
                BlocBuilder<ImagesBloc, ImagesState>(
                    buildWhen: (prev, curr) => prev.viewType != curr.viewType,
                    builder: (_, state) {
                      return IconButton(
                        icon: Icon(
                          state.viewType == GalleryViewType.grid
                              ? Icons.list
                              : Icons.grid_view,
                          color: Colors.grey.shade700,
                        ),
                        onPressed: () {
                          context.read<ImagesBloc>().add(ImagesEvent.ChangeView(
                                viewType: state.viewType == GalleryViewType.grid
                                    ? GalleryViewType.list
                                    : GalleryViewType.grid,
                              ));
                        },
                      );
                    }),
              ],
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                stretchModes: const [StretchMode.fadeTitle],
                titlePadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                background: Container(
                  color: Theme.of(context).colorScheme.surface,
                ),
                centerTitle: true,
                title: Text(
                  AppLocalizations.of(context)?.name ?? "",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            )
          ];
        },
        body: BlocBuilder<ImagesBloc, ImagesState>(
          builder: (_, state) {
            if (state.status == BaseStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == BaseStatus.error) {
              return Center(child: Text(state.message ?? ""));
            } else if (state.status == BaseStatus.success ||
                state.status == BaseStatus.loadMore) {
              if (state.data.isEmpty) {
                return const Center(child: Text("No data"));
              }

              return SmartRefresher(
                controller: context.read<ImagesBloc>().refreshController,
                enablePullDown: true,
                enablePullUp: state.hasMoreData,
                onRefresh: () {
                  context.read<ImagesBloc>().add(const ImagesEvent.GetImages());
                },
                onLoading: () {
                  context
                      .read<ImagesBloc>()
                      .add(ImagesEvent.GetImages(page: state.page + 1));
                },
                child: state.viewType == GalleryViewType.grid
                    ? GalleryGridView(
                        data: state.data,
                        onPressed: (id) {},
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        itemCount: state.data.length,
                        separatorBuilder: (_, index) =>
                            const SizedBox(height: 8),
                        itemBuilder: (_, index) => GalleryListItem(
                          data: state.data[index],
                          onPressed: (id) {
                            context.go("${GalleryRoute.path}/$id");
                          },
                        ),
                      ),
              );
            }

            return const Center(child: Text("No data"));
          },
        ),
      ),
    );
  }
}

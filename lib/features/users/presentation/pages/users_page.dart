import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:awesome_app/core/constant/base_constant.dart';
import 'package:awesome_app/core/di/injection.dart';
import 'package:awesome_app/features/users/presentation/bloc/users/users_bloc.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UsersBloc(getUsersUc: injector.get())
            ..add(const UsersEvent.GetUsers()),
        ),
      ],
      child: const _UsersLayout(),
    );
  }
}

class _UsersLayout extends StatelessWidget {
  const _UsersLayout();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (_, state) {
          if (state.status == BaseStatus.success || state.page > 1) {
            return SmartRefresher(
              controller: context.read<UsersBloc>().refreshController,
              enablePullDown: true,
              enablePullUp: state.hasMoreData,
              onLoading: () {
                context.read<UsersBloc>().add(UsersEvent.GetUsers(
                      page: state.page + 1,
                    ));
              },
              onRefresh: () {
                context.read<UsersBloc>().add(const UsersEvent.GetUsers());
              },
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                itemCount: state.data.length,
                separatorBuilder: (_, index) => const SizedBox(height: 16),
                itemBuilder: (_, index) => ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                      width: 1,
                    ),
                  ),
                  title: Text(state.data[index].firstName ?? ""),
                  subtitle: Text(state.data[index].email ?? ""),
                ),
              ),
            );
          } else if (state.status == BaseStatus.error) {
            return Center(
              child: Text(state.message ?? ""),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

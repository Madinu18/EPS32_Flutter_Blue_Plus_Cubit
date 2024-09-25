part of "widgets.dart";

class CostumTabBar extends TabBar {
  CostumTabBar({
    required TabController tabController,
    required List<String> tabs,
    required Color labelColor,
    required Function(int) onTap,
    double fontSize = 18,
  }) : super(
          unselectedLabelStyle: whiteTextFont.copyWith(fontSize: fontSize),
          labelStyle: whiteTextFontTitle.copyWith(fontSize: fontSize),
          unselectedLabelColor: blackColor,
          controller: tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 1,
          indicatorColor: labelColor,
          labelColor: labelColor,
          onTap: onTap,
          //isScrollable: true,
          tabs: tabs.map<Widget>(
            (String tab) {
              return Tab(
                text: tab,
              );
            },
          ).toList(),
        );
}

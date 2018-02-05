# home-task

Inside project you will find two modules:
- Feed
- Picture Preview

"Feed" module (as more complex) devided into 2 layers: UI & business logic. It makes possible to test main use cases.
"Picture Preview" module is tiny and any other solution than just `UIViewController` seems to be overhead. Also it makes easier to implement preserving and restoring state, because `UIViewController` plays an important role it this process.
Content for "Feed" is remote collection which changes frequenlty and becames not actual over short period of time, so I do not preserve/restore it.

Known issues:
- `UIAlertController` sometimes prevents `UIRefreshControl` to hide. It can be reproduced if reloading items after pull-to-refresh failed.
Can be fixed by implementing/using custom UI for user notifications.
- Blinking after loading next page, caused by full reload of `UITableView`.
Can be fixed by implementing more sophisticated solution for updating `UITableView`

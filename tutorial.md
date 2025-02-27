# Firebase UI Authentication in Flutter

## Step 1: Configure Firebase Options

Install firebase CLI:

```bash
curl -sL https://firebase.tools | bash
```

Run the Firebase CLI to generate `firebase_options.dart`:

```bash
dart pub global activate flutterfire_cli
```

Add firebase to your path:

```bash
echo 'export PATH="$PATH":"$HOME/.pub-cache/bin"' >> ~/.bashrc
source ~/.bashrc
```

```bash
dart pub global activate flutterfire_cli
firebase login
flutterfire configure
```

# flutter_lints commands
```bash
flutter analyze
dart fix --apply
```

class AppStrings {
  // App Info
  static const String appName = 'My Todo';
  static const String appVersion = '1.0.0';

  // Authentication - Login
  static const String login = 'Login';
  static const String loginTitle = 'Welcome Back';
  static const String loginSubtitle = 'Sign in to continue';
  static const String email = 'Email';
  static const String emailHint = 'Enter your email';
  static const String password = 'Password';
  static const String passwordHint = 'Enter your password';
  static const String forgotPassword = 'Forgot Password?';
  static const String dontHaveAccount = 'Don\'t have an account?';
  static const String signUp = 'Sign Up';
  static const String signIn = 'Sign In';
  static const String loggingIn = 'Logging in...';
  static const String rememberMe = 'Remember me';
  static const String continueWithGoogle = 'Continue with Google';
  static const String continueWithApple = 'Continue with Apple';
  static const String continueWithFacebook = 'Continue with Facebook';
  static const String orContinueWith = 'Or continue with';

  // Authentication - Sign Up
  static const String signUpTitle = 'Create Account';
  static const String signUpSubtitle = 'Sign up to get started';
  static const String fullName = 'Full Name';
  static const String fullNameHint = 'Enter your full name';
  static const String confirmPassword = 'Confirm Password';
  static const String confirmPasswordHint = 'Re-enter your password';
  static const String alreadyHaveAccount = 'Already have an account?';
  static const String creatingAccount = 'Creating account...';
  static const String agreeToTerms = 'I agree to the Terms & Conditions';
  static const String agreeToPrivacy = 'I agree to the Privacy Policy';

  // Authentication - Forgot Password
  static const String forgotPasswordTitle = 'Forgot Password';
  static const String forgotPasswordSubtitle = 'Enter your email to reset password';
  static const String resetPassword = 'Reset Password';
  static const String resetPasswordTitle = 'Reset Password';
  static const String resetPasswordSubtitle = 'Enter your new password';
  static const String newPassword = 'New Password';
  static const String newPasswordHint = 'Enter new password';
  static const String sendResetLink = 'Send Reset Link';
  static const String backToLogin = 'Back to Login';
  static const String resetLinkSent = 'Reset link sent to your email';
  static const String checkYourEmail = 'Check your email';

  // Authentication - Validation
  static const String errorInvalidEmail = 'Please enter a valid email';
  static const String errorEmptyEmail = 'Email is required';
  static const String errorEmptyPassword = 'Password is required';
  static const String errorPasswordTooShort = 'Password must be at least 6 characters';
  static const String errorPasswordsNotMatch = 'Passwords do not match';
  static const String errorEmptyName = 'Name is required';
  static const String errorInvalidCredentials = 'Invalid email or password';
  static const String errorEmailAlreadyExists = 'Email already exists';
  static const String errorWeakPassword = 'Password is too weak';
  static const String errorUserNotFound = 'User not found';
  static const String errorTooManyRequests = 'Too many requests. Please try again later';
  static const String errorNetworkError = 'Network error. Check your connection';
  static const String errorAgreeToTerms = 'Please agree to Terms & Conditions';

  // Authentication - Success
  static const String loginSuccess = 'Login successful';
  static const String signUpSuccess = 'Account created successfully';
  static const String passwordResetSuccess = 'Password reset successful';
  static const String logoutSuccess = 'Logged out successfully';

  // Authentication - Profile
  static const String profile = 'Profile';
  static const String editProfile = 'Edit Profile';
  static const String changePassword = 'Change Password';
  static const String currentPassword = 'Current Password';
  static const String logout = 'Logout';
  static const String logoutTitle = 'Logout';
  static const String logoutMessage = 'Are you sure you want to logout?';
  static const String deleteAccount = 'Delete Account';
  static const String deleteAccountTitle = 'Delete Account';
  static const String deleteAccountMessage = 'Are you sure you want to delete your account? This action cannot be undone.';

  // General
  static const String ok = 'OK';
  static const String cancel = 'Cancel';
  static const String save = 'Save';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String done = 'Done';
  static const String back = 'Back';
  static const String close = 'Close';
  static const String confirm = 'Confirm';
  static const String yes = 'Yes';
  static const String no = 'No';
  static const String search = 'Search';
  static const String filter = 'Filter';
  static const String sort = 'Sort';

  // Home Screen
  static const String homeTitle = 'My Tasks';
  static const String addTask = 'Add Task';
  static const String noTasks = 'No tasks yet';
  static const String noTasksDescription = 'Tap the + button to create your first task';
  static const String allTasks = 'All Tasks';
  static const String completedTasks = 'Completed';
  static const String pendingTasks = 'Pending';
  static const String todayTasks = 'Today';
  static const String upcomingTasks = 'Upcoming';
  static const String overdueTasks = 'Overdue';

  // Add/Edit Task
  static const String createTask = 'Create Task';
  static const String editTask = 'Edit Task';
  static const String taskTitle = 'Task Title';
  static const String taskTitleHint = 'Enter task title';
  static const String taskDescription = 'Description';
  static const String taskDescriptionHint = 'Enter task description (optional)';
  static const String dueDate = 'Due Date';
  static const String dueTime = 'Due Time';
  static const String selectDate = 'Select Date';
  static const String selectTime = 'Select Time';
  static const String priority = 'Priority';
  static const String category = 'Category';
  static const String reminder = 'Reminder';
  static const String setReminder = 'Set Reminder';
  static const String repeat = 'Repeat';
  static const String notes = 'Notes';

  // Priority Levels
  static const String priorityHigh = 'High';
  static const String priorityMedium = 'Medium';
  static const String priorityLow = 'Low';
  static const String priorityNone = 'None';

  // Categories
  static const String categoryWork = 'Work';
  static const String categoryPersonal = 'Personal';
  static const String categoryShopping = 'Shopping';
  static const String categoryHealth = 'Health';
  static const String categoryOther = 'Other';
  static const String addCategory = 'Add Category';
  static const String manageCategories = 'Manage Categories';

  // Repeat Options
  static const String repeatNone = 'Never';
  static const String repeatDaily = 'Daily';
  static const String repeatWeekly = 'Weekly';
  static const String repeatMonthly = 'Monthly';
  static const String repeatYearly = 'Yearly';
  static const String repeatCustom = 'Custom';

  // Task Actions
  static const String markComplete = 'Mark as Complete';
  static const String markIncomplete = 'Mark as Incomplete';
  static const String deleteTask = 'Delete Task';
  static const String duplicateTask = 'Duplicate Task';
  static const String shareTask = 'Share Task';
  static const String moveTask = 'Move Task';

  // Search & Filter
  static const String searchTasks = 'Search tasks...';
  static const String filterByCategory = 'Filter by Category';
  static const String filterByPriority = 'Filter by Priority';
  static const String filterByDate = 'Filter by Date';
  static const String sortByDate = 'Sort by Date';
  static const String sortByPriority = 'Sort by Priority';
  static const String sortByTitle = 'Sort by Title';
  static const String clearFilters = 'Clear Filters';
  static const String noResultsFound = 'No results found';
  static const String noResultsDescription = 'Try adjusting your search or filters';

  // Statistics
  static const String statistics = 'Statistics';
  static const String totalTasks = 'Total Tasks';
  static const String completedToday = 'Completed Today';
  static const String completionRate = 'Completion Rate';
  static const String productivity = 'Productivity';

  // Settings
  static const String settings = 'Settings';
  static const String notifications = 'Notifications';
  static const String enableNotifications = 'Enable Notifications';
  static const String theme = 'Theme';
  static const String lightMode = 'Light Mode';
  static const String darkMode = 'Dark Mode';
  static const String systemDefault = 'System Default';
  static const String language = 'Language';
  static const String about = 'About';
  static const String help = 'Help';
  static const String privacy = 'Privacy Policy';
  static const String terms = 'Terms of Service';
  static const String rateApp = 'Rate App';
  static const String shareApp = 'Share App';

  // Validation Messages
  static const String errorEmptyTitle = 'Please enter a task title';
  static const String errorInvalidDate = 'Please select a valid date';
  static const String errorPastDate = 'Due date cannot be in the past';
  static const String errorGeneral = 'Something went wrong. Please try again.';

  // Success Messages
  static const String taskCreated = 'Task created successfully';
  static const String taskUpdated = 'Task updated successfully';
  static const String taskDeleted = 'Task deleted successfully';
  static const String taskCompleted = 'Task completed! 🎉';
  static const String taskRestored = 'Task restored';
  static const String categorySaved = 'Category saved';
  static const String settingsSaved = 'Settings saved';

  // Confirmation Dialogs
  static const String deleteTaskTitle = 'Delete Task?';
  static const String deleteTaskMessage = 'Are you sure you want to delete this task? This action cannot be undone.';
  static const String deleteCompletedTitle = 'Delete Completed Tasks?';
  static const String deleteCompletedMessage = 'Are you sure you want to delete all completed tasks?';
  static const String discardChangesTitle = 'Discard Changes?';
  static const String discardChangesMessage = 'You have unsaved changes. Do you want to discard them?';

  // Empty States
  static const String noCompletedTasks = 'No completed tasks';
  static const String noCompletedTasksDescription = 'Complete tasks to see them here';
  static const String noPendingTasks = 'No pending tasks';
  static const String noPendingTasksDescription = 'You\'re all caught up! 🎉';
  static const String noOverdueTasks = 'No overdue tasks';
  static const String noOverdueTasksDescription = 'Great job staying on track!';

  // Date & Time
  static const String today = 'Today';
  static const String tomorrow = 'Tomorrow';
  static const String yesterday = 'Yesterday';
  static const String thisWeek = 'This Week';
  static const String nextWeek = 'Next Week';
  static const String overdue = 'Overdue';
  static const String noDueDate = 'No due date';

  // Accessibility
  static const String addTaskButton = 'Add new task button';
  static const String completeTaskCheckbox = 'Complete task checkbox';
  static const String deleteTaskButton = 'Delete task button';
  static const String editTaskButton = 'Edit task button';

  // Notifications
  static const String notificationTitle = 'Task Reminder';
  static const String notificationBody = 'Don\'t forget about your task!';
  static const String notificationChannelName = 'Task Reminders';
  static const String notificationChannelDescription = 'Reminders for your tasks';

  // Undo
  static const String undo = 'Undo';
  static const String redo = 'Redo';

  // Sync
  static const String sync = 'Sync';
  static const String syncing = 'Syncing...';
  static const String syncComplete = 'Sync complete';
  static const String syncFailed = 'Sync failed';
  static const String lastSynced = 'Last synced';
}
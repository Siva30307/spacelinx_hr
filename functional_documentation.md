# SpaceLinx HR - Functional Documentation

## 1. Executive Summary
SpaceLinx HR is a comprehensive mobile application designed to manage employee lifecycles, attendance, leaves, and organizational data. The application is feature-driven, meaning the user experience is divided into distinct operational modules.

## 2. Core Functional Modules

The application is functionally divided into the following primary modules (as reflected in the UI screens):

### 2.1 Authentication (`auth`)
Handles secure access to the ecosystem.
- **Microsoft Authentication**: Users log in via Microsoft Azure Active Directory (MSAL).
- **Token Management**: The application handles access tokens for authorized secure API calls to the backend endpoints.

### 2.2 Dashboard (`dashboard`)
The landing experience post-login.
- Provides a high-level overview of critical HR metrics.
- Utilizes graphical charts (`fl_chart`) to represent data visually to the user.
- Acts as a navigation hub to other core modules.

### 2.3 Employee Management (`employee`)
Handles the lifecycle and details of organizational personnel.
- **Employee List View**: Browsable directory of all employees.
- **Employee Details**: In-depth view of a specific employee's profile, history, and contact information.
- **Employee Creation**: Interface to onboard or register new employees into the system.
- **Onboarding Overview**: Dedicated tracking for employees in the onboarding phase.
- **Separation Tracking**: Workflows for employees exiting the organization.
- **Employee Overview**: A summarized view of overall employee metrics within a unit or department.

### 2.4 Attendance (`attendance`)
Tracks daily employee presence and working hours.
- **Shift Management**: Interfaces for viewing and assigning shifts.
- Tracks check-ins and check-outs against assigned schedules.

### 2.5 Leave Management (`leave`)
Manages employee time off, balances, and policies.
- **Leave Overview**: Personal dashboard for a user to see their available leaves.
- **Leave Balances**: Detailed tracking of accrued vs. spent leave allocations.
- **Leave Requesting**: Form-based interface to apply for future time off (`leave_request_form_screen`).
- **Leave History/List**: A list of past, pending, and approved leave requests.
- **Leave Policies & Types**: Read-only views outlining company rules regarding different leave types (e.g., Sick, Casual, Annual).
- **Holiday Calendar**: Visual reference for company-wide public holidays to aid in leave planning.

## 3. User Experience (UX) Flow
1. **Entry**: User opens the app and is challenged by the `auth` module.
2. **Landing**: Upon successful MSAL authentication, the user lands on the `dashboard`.
3. **Execution**: From the dashboard, users utilize common UI navigation (e.g., bottom tabs or side menus) to navigate to specific features (`employee`, `leave`, `attendance`) based on their role and intent.
4. **Data Interaction**: Through forms (like the leave request form) and lists (like the employee directory), users read from and write to the central HR database seamlessly.

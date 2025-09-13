# Onboarding & Authentication Flow

This document describes the complete onboarding and authentication flow implemented for the CookingBuddy app.

## 🎨 Design System

### Colors
- **Primary Orange**: `#FF6B35` - Used for primary buttons, highlights, and branding
- **Secondary Green**: `#4ECDC4` - Used for accents and secondary elements
- **Background**: `#F8F9FA` - Light gray background throughout the app
- **Text Primary**: `#2C3E50` - Dark gray for main text
- **Text Secondary**: `#718096` - Medium gray for secondary text
- **Card Background**: `#FFFFFF` - White cards with soft shadows

### Typography
- Clean, modern sans-serif font (system default)
- Bold titles (24-28px)
- Regular body text (16px)
- Secondary text (14px)

### UI Elements
- Rounded corners (12-25px border radius)
- Soft shadows with low opacity
- Pill-shaped buttons
- Consistent 16-24px padding

## 📱 Flow Structure

### 1. Splash Screen
**File**: `lib/features/splash/presentation/pages/splash_page.dart`

- Animated app logo with gradient background
- 2-second animation with fade and scale effects
- Automatically navigates to onboarding
- Future: Check user authentication state

### 2. Onboarding Flow (3 Screens)
**Files**: 
- `lib/features/onboarding/presentation/pages/onboarding_page.dart`
- `lib/features/onboarding/presentation/widgets/onboarding_screen.dart`

#### Screen 1: Discover Recipes
- **Icon**: Restaurant menu outline
- **Title**: "Discover Recipes Easily"
- **Subtitle**: "Find inspiration from thousands of home-cooked recipes."
- **Color**: Primary Orange

#### Screen 2: AI Cooking Partner
- **Icon**: Smart toy outline (robot)
- **Title**: "Your AI Cooking Partner"
- **Subtitle**: "Enter ingredients and get step-by-step recipes instantly."
- **Color**: Secondary Green

#### Screen 3: Share & Connect
- **Icon**: People outline
- **Title**: "Share & Connect"
- **Subtitle**: "Like, comment, and exchange cooking ideas with the community."
- **Color**: Primary Orange

**Features**:
- Smooth page transitions
- Progress indicator (3 dots)
- "Next" button transforms to "Get Started" on final screen
- Swipe navigation support

### 3. Authentication Screens

#### Login Page
**File**: `lib/features/auth/presentation/pages/login_page.dart`

**Features**:
- Email and password fields with validation
- Password visibility toggle
- Loading state with spinner
- "Forgot Password" link
- Social login buttons (Google & Facebook)
- Navigation to signup

**Validation**:
- Email format validation
- Required field validation
- Real-time error display

#### Signup Page
**File**: `lib/features/auth/presentation/pages/signup_page.dart`

**Features**:
- Full name, email, and password fields
- Password strength validation (minimum 6 characters)
- Same social login options as login
- Navigation back to login

### 4. Shared Components

#### AuthCard Widget
**File**: `lib/features/auth/presentation/widgets/auth_card.dart`
- White card with soft shadow
- Consistent padding and styling
- Reusable across auth screens

#### SocialLoginButton Widget
**File**: `lib/features/auth/presentation/widgets/social_login_button.dart`
- Configurable icon, text, and colors
- Google: White background with border
- Facebook: Blue background
- Full-width responsive design

## 🔧 Technical Implementation

### State Management
- Uses Riverpod for state management
- Form validation with GlobalKey<FormState>
- Loading states for async operations

### Navigation
- MaterialPageRoute for screen transitions
- pushReplacement for one-way navigation (splash → onboarding → auth → main app)
- Proper back navigation on signup screen

### Animations
- Splash screen: Fade and scale animations
- Onboarding: Smooth page transitions with curves
- Button interactions: Material design ripple effects

### Form Handling
- TextEditingController for input management
- Comprehensive validation rules
- Error state management
- Password visibility toggle

## 🚀 Usage

### Starting the Flow
The app automatically starts with the splash screen and progresses through:
1. Splash (2 seconds) → 2. Onboarding (3 screens) → 3. Authentication → 4. Main App

### Customization
- Update colors in `lib/core/theme/app_colors.dart`
- Modify onboarding content in `onboarding_page.dart`
- Add authentication logic in login/signup pages
- Integrate with backend services for real authentication

### 5. Forgot Password Flow

#### Forgot Password Page
**File**: `lib/features/auth/presentation/pages/forgot_password_page.dart`

**Features**:
- Email input with validation
- Clear instructions and helpful messaging
- Loading state during email sending
- Navigation back to login

#### Reset Password Success Page
**File**: `lib/features/auth/presentation/pages/reset_password_success_page.dart`

**Features**:
- Email confirmation display
- Resend email functionality
- Clear next steps instructions
- Timer indication (15 minutes)
- Help text for troubleshooting

#### Create New Password Page
**File**: `lib/features/auth/presentation/pages/create_new_password_page.dart`

**Features**:
- New password and confirmation fields
- Strong password requirements display
- Real-time validation
- Password visibility toggles
- Security requirements checklist

#### Password Reset Complete Page
**File**: `lib/features/auth/presentation/pages/password_reset_complete_page.dart`

**Features**:
- Success animation
- Security confirmation badges
- Navigation back to login
- Security tips and best practices

### Future Enhancements
- Add SharedPreferences to skip onboarding for returning users
- Implement real authentication with Firebase/backend
- Add biometric authentication
- Social login integration
- Email verification flow
- Two-factor authentication

## 📁 File Structure

```
lib/features/
├── splash/
│   └── presentation/pages/splash_page.dart
├── onboarding/
│   └── presentation/
│       ├── pages/onboarding_page.dart
│       └── widgets/onboarding_screen.dart
└── auth/
    └── presentation/
        ├── pages/
        │   ├── login_page.dart
        │   ├── signup_page.dart
        │   ├── forgot_password_page.dart
        │   ├── reset_password_success_page.dart
        │   ├── create_new_password_page.dart
        │   ├── password_reset_complete_page.dart
        │   └── forgot_password_demo_page.dart
        └── widgets/
            ├── auth_card.dart
            └── social_login_button.dart
```

## 🔄 Complete Forgot Password Flow

### User Journey
1. **Login Screen** → User clicks "Forgot Password?"
2. **Forgot Password** → User enters email and clicks "Send Reset Link"
3. **Check Email** → User sees confirmation and can resend if needed
4. **Email Link** → User clicks link in email (opens Create New Password)
5. **Create New Password** → User sets new password with validation
6. **Reset Complete** → Success confirmation with security tips
7. **Back to Login** → User can now login with new password

### Security Features
- **Email Validation**: Proper email format checking
- **Strong Password Requirements**: 8+ chars, uppercase, lowercase, number
- **Password Confirmation**: Ensures passwords match
- **Token Validation**: Reset tokens expire in 15 minutes
- **Rate Limiting**: Prevents spam reset requests
- **Security Tips**: User education about password safety

### UX Considerations
- **Clear Instructions**: Each step explains what to do next
- **Progress Indication**: Users know where they are in the flow
- **Error Handling**: Helpful error messages and recovery options
- **Accessibility**: Proper contrast, touch targets, and screen reader support
- **Responsive Design**: Works on all device sizes

The implementation follows clean architecture principles with clear separation of concerns and reusable components.
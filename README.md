<h1 align="center"> Mini Product Showcase App</h1>

<p align="center">
A production-ready Flutter application demonstrating Clean Architecture,
scalable structure, offline support, and BLoC state management.
</p>

<hr/>

<h2> Features</h2>

<h3> Authentication</h3>
<ul>
  <li>Email & Password validation</li>
  <li>Dummy authentication logic (no backend)</li>
  <li>Proper form validation & error handling</li>
  <li>Reusable form field widgets</li>
</ul>

<h3>🛍 Product Listing</h3>
<ul>
  <li>Fetch products from FakeStore API</li>
  <li>Responsive Grid/List layout</li>
  <li>Displays product image, title, price, and rating</li>
</ul>

<h3>📄 Product Details</h3>
<ul>
  <li>Detailed product information</li>
  <li>Add / Remove from Favorites</li>
  <li>Local storage persistence</li>
</ul>

<h3>💾 Offline Support</h3>
<ul>
  <li>Cached API response using Hive</li>
  <li>Loads cached data when offline</li>
</ul>

<h3>🎨 Theme Support</h3>
<ul>
  <li>Light & Dark mode toggle</li>
  <li>Theme preference stored using SharedPreferences</li>
</ul>

<hr/>

<h2>🏗 Architecture Overview</h2>

<pre>
lib/
 ├── core/
 │   ├── error/
 │   ├── network/
 │   ├── theme/
 │   ├── utils/
 │
 ├── features/
 │   ├── auth/
 │   │   ├── data/
 │   │   ├── domain/
 │   │   ├── presentation/
 │   │
 │   ├── products/
 │       ├── data/
 │       ├── domain/
 │       ├── presentation/
 │
 └── main.dart
</pre>

<h3>Layer Responsibilities</h3>

<ul>
  <li><strong>Presentation Layer:</strong> UI, BLoC, State handling</li>
  <li><strong>Domain Layer:</strong> Entities, UseCases, Repository interfaces</li>
  <li><strong>Data Layer:</strong> Models, API calls, Local storage, Repository implementations</li>
</ul>

<h3>Principles Applied</h3>
<ul>
  <li>Clean Architecture</li>
  <li>SOLID Principles</li>
  <li>Repository Pattern</li>
  <li>Dependency Injection</li>
  <li>Separation of Concerns</li>
</ul>

<hr/>

<h2>📦 Tech Stack</h2>

<ul>
  <li>Flutter</li>
  <li>BLoC</li>
  <li>Hive</li>
  <li>HTTP</li>
  <li>SharedPreferences</li>
  <li>FakeStore API</li>
</ul>

<hr/>












<hr/>

<h2>🎥 Screen Recording</h2>

<p>
Add your demo video link here:
<br/>
<a href="https://github.com/Dhruv9696490/mini_product_showcase_app/blob/master/Video%20Project%201.mp4">Watch Demo</a>
</p>

<hr/>

<h2>📌 Submission Details</h2>

<ul>
  <li>Architecture: Clean Architecture</li>
  <li>State Management: BLoC</li>
  <li>Offline Support: Hive</li>
  <li>Theme Support: Light & Dark Mode</li>
</ul>

<hr/>

<p align="center">
Developed by Dhruv Soni
</p>

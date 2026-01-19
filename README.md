Waste Not Project
About the Project

Waste Not is a project made to reduce food waste by connecting people who have extra food with people or organizations who need it.

The main goal of Waste Not is:

Reduce food wastage

Help needy people get food

Support NGOs, hostels, and shelters

Create awareness about responsible food usage

What Waste Not Does

Waste Not allows:

Hotels, restaurants, homes, and events to post extra food

NGOs or volunteers to see available food nearby

Easy communication between donor and receiver

Tracking of food donation history

Main Features

User registration and login

Food donation posting

Location-based food listing

Request and accept food

NGO and volunteer support

Admin panel to manage users and data

How to Run Waste Not Project After Download

Follow these steps to run the project on your computer.

Step 1: Download the Project

You can get the project by:

Downloading ZIP from GitHub and extracting it
or

Using git command:

git clone <project-repo-link>


Then go into the project folder:

cd waste-not

Step 2: Install Required Software

Make sure you have:

Node.js installed

npm (comes with Node.js)

MongoDB or any database used in your project

Check versions:

node -v
npm -v

Step 3: Install Dependencies

Run this in the project folder:

npm install


If there is a frontend and backend folder:

cd backend
npm install
cd ../frontend
npm install

Step 4: Setup Environment File

Create a file named .env in backend folder and add:

PORT=5000
DB_URL=your_database_url
JWT_SECRET=your_secret_key


Change values according to your setup.

Step 5: Start Backend Server
cd backend
npm start


or

npm run dev


Server will start on:

http://localhost:5000

Step 6: Start Frontend

Open new terminal:

cd frontend
npm start


Frontend will open on:

http://localhost:3000

Step 7: Open in Browser

Go to:

http://localhost:3000


Now you can:

Register user

Add food

Request food

Test full system

Common Problems

If error comes: run npm install again

If database not connecting: check .env file

If port busy: change port number in .env
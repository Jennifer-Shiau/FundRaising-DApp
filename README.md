# FundRaising DApp
### 108-1 Networking & Multimedia Lab Final Project
The Fundraising DApp makes donations safer, easier, and more trustworthy with blockchain features.


## Usage
### Project Setup
- Clone repo
```
$ git clone https://github.com/nicolercl/FundRaising-DApp.git
```
- Install packages
```
$ cd FundRaising-DApp/
$ npm install
$ cd fundraiser/
$ npm install
```
- Open Ganache
```
$ cd ..
$ truffle compile
$ truffle migrate
```

### Run
```
$ cd fundraiser/
$ npm run serve
```
- Open your browser and enter `localhost:8080` in the URL bar
- Log in and connect to MetaMask

### MetaMask Settings
- Create a MetaMask account
    - Import account.
    - Paste the private key of a ganache account.
- Add token

    <img src="https://i.imgur.com/t95M7EH.png" width="200">

    - Choose `Custom Token`.
    - Enter **Contract Address** of Fundraiser and **Token Symbol** (e.g. FR). Set **Decimals of Precision** to 0.
- Add network
    - Click `Settings`.
    
    <img src="https://i.imgur.com/G4ah1xW.png" width="200">
    
    - Choose `Networks` > `Add Network`.
    - Set like this.
    
    <img src="https://i.imgur.com/wDvD94h.png" width="200">

- Log out of MetaMask. Log in again and connect to the new account you just imported.


## Features
### Raise Funds
- Sign up / Log in
    - Click `SIGN UP` / `LOG IN` on the upper right corner of the window.
    - Enter your username and password.
    
    <img src="https://i.imgur.com/zGamuqm.png" width="500">

- Create event
    - Go to the `PROFILE` page and click `CREATE EVENT`.
    - Enter event information.
    - Each event needs its own MetaMask account.
    
    <img src="https://i.imgur.com/am6nFqB.png" width="500">

- Post
    - Go to the `PROFILE` page.
    
    ![](https://i.imgur.com/sJGA4Xw.png)

- Add introductions about yourself or your events


### Make Donations
- Log in
    - You do NOT need to create an account in our website.
    - Log in with your MetaMask account.
- Explore
    - View events on the `HOME` page.
    
    ![](https://i.imgur.com/FaUicmQ.png)

    - View information about organizations.
        - You can reply to posts.
    
    ![](https://i.imgur.com/SeSIt8I.png)
        
    - View information about events.
        - You can leave comments or reply to comments.
    
    ![](https://i.imgur.com/Icaykrt.png)

- Feedback
    - You can provide feedback for an organization or an event by pressing thumbs up or down.
- Donate
    - Information of an event is displayed on the event page.
    - Click `DONATE` and enter the amount you want to donate.

    <img src="https://i.imgur.com/q9KkqVi.png" width="500">

## Demo Video
[Link]()

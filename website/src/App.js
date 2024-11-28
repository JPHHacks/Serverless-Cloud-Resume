import React, { useState, useEffect } from "react";
import { BrowserRouter, Route, Routes } from "react-router-dom";
import {
  navBar,
  mainBody,
  about,
  repos,
  leadership,
  skills,
  getInTouch,
  experiences
} from "./editable-stuff/config.js";
import MainBody from "./components/home/MainBody";
import AboutMe from "./components/home/AboutMe";
import Project from "./components/home/Project";
import Footer from "./components/Footer";
import Navbar from "./components/Navbar";
import Skills from "./components/home/Skills";
import GetInTouch from "./components/home/GetInTouch.jsx";
import Leadership from "./components/home/Leadership.jsx";
import Experience from "./components/home/Experience";

const getViewCount = async () => {
  try {
    const response = await fetch('https://7q9qycq5e6.execute-api.us-east-1.amazonaws.com/prod');
    const data = await response.text();
    const count = parseInt(data, 10);
    if (!isNaN(count)) {
      return count;
    } else {
      return 0;
    }
  } catch (error) {
    return 0;
  }
};

const Home = ({ viewCount, loading }) => {
  return (
    <>
      <MainBody
        gradient={mainBody.gradientColors}
        title={`${mainBody.firstName} ${mainBody.middleName} ${mainBody.lastName}`}
        message={mainBody.message}
        icons={mainBody.icons}
        viewCount={viewCount}
        loading={loading}
      />
      {about.show && (
        <AboutMe
          heading={about.heading}
          message={about.message}
          link={about.imageLink}
          imgSize={about.imageSize}
          resume={about.resume}
        />
      )}
      {repos.show && (
        <Project
          heading={repos.heading}
          username={repos.gitHubUsername}
          length={repos.reposLength}
          specfic={repos.specificRepos}
        />
      )}
      {skills.show && (
        <Skills
          heading={skills.heading}
          hardSkills={skills.hardSkills}
          softSkills={skills.softSkills}
        />
      )}
      {leadership.show && <Leadership />}
      {experiences.show && <Experience experiences={experiences} />}
    </>
  );
};

const App = () => {
  const [viewCount, setViewCount] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchViewCount = async () => {
      setLoading(true);
      try {
        const count = await getViewCount();
        setViewCount(count);
      } catch (error) {
        setViewCount(0);
      } finally {
        setLoading(false);
      }
    };
    fetchViewCount();
  }, []);

  return (
    <BrowserRouter basename={process.env.PUBLIC_URL}>
      {navBar.show && <Navbar />}
      <Routes>
        <Route path="/" element={<Home viewCount={viewCount} loading={loading} />} />
      </Routes>
      <Footer>
        {getInTouch.show && (
          <GetInTouch
            heading={getInTouch.heading}
            message={getInTouch.message}
            email={getInTouch.email}
          />
        )}
      </Footer>
    </BrowserRouter>
  );
};

export default App;
// Navigation Bar SECTION
const navBar = {
  show: true,
};

// Main Body SECTION
const mainBody = {
  gradientColors: "#4484ce, #1ad7c0, #ff9b11, #9b59b6, #ff7f7f, #ecf0f1",
  firstName: "Jean Paul",
  middleName: "",
  lastName: "Heymann",
  message: " Driven to protect and transform the digital landscape with cybersecurity. ",
  icons: [
    {
      image: "fa-github",
      url: "https://github.com/JPHHacks",
    },
    {
      image: "fa-facebook",
      url: "https://www.facebook.com",
    },
    {
      image: "fa-instagram",
      url: "https://www.instagram.com",
    },
    {
      image: "fa-linkedin",
      url: "https://www.linkedin.com/in/jean-paul-heymann-618b00255/",
    },
    {
      image: "fa-twitter",
      url: "https://www.twitter.com",
    },
  ],
};

// ABOUT SECTION
// If you want the About Section to show a profile picture you can fill the profilePictureLink either with:
//a) your Instagram username
//      i.e:profilePictureLink:"johnDoe123",
//b) a link to an hosted image
//      i.e:profilePictureLink:"www.picturesonline.com/johnDoeFancyAvatar.jpg",
//c) image in "editable-stuff" directory and use require("") to import here,
//      i.e: profilePictureLink: require("../editable-stuff/hashirshoaeb.png"),
//d) If you do not want any picture to be displayed, just leave it empty :)
//      i.e: profilePictureLink: "",
// For Resume either provide link to your resume or import from "editable-stuff" directory
//     i.e resume: require("../editable-stuff/resume.pdf"),
//         resume: "https://docs.google.com/document/d/13_PWdhThMr6roxb-UFiJj4YAFOj8e_bv3Vx9UHQdyBQ/edit?usp=sharing",

const about = {
  show: true,
  heading: "About Me",
  imageLink: require("../editable-stuff/JPHHacks.jpg"),
  imageSize: 375,
  message:
    "My name is JP Heymann. I’m a recent graduate with a bachelor’s in cybersecurity from Palm Beach State College and a member of the Ethical Hacking Club, I have developed strong skills in identifying system vulnerabilities, deploying automated technologies, identifying malicious activities, and evaluating network security. I’m passionate about cloud security and continuously seeking ways to secure cloud environments, ensuring data integrity, confidentiality, and availability across digital infrastructures.",
  resume: "https://drive.google.com/file/d/1K5jRYmymMw2qZli-s4i7ecedxWLFCxi_/view?usp=sharing",
};

// PROJECTS SECTION
// Setting up project lenght will automatically fetch your that number of recently updated projects, or you can set this field 0 to show none.
//      i.e: reposLength: 0,
// If you want to display specfic projects, add the repository names,
//      i.e ["repository-1", "repo-2"]
const repos = {
  show: true,
  heading: "Recent Projects",
  gitHubUsername: "JPHHacks", //i.e."johnDoe12Gh"
  reposLength: 1,
  specificRepos: [],
};

// Leadership SECTION
const leadership = {
  show: false,
  heading: "Leadership",
  message:
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vitae auctor eu augue ut lectus arcu bibendum at varius. Libero justo laoreet sit amet cursus sit amet. Imperdiet dui accumsan sit amet nulla facilisi morbi. At auctor urna nunc id. Iaculis urna id volutpat lacus laoreet non curabitur gravida. Et magnis dis parturient montes nascetur ridiculus mus mauris. In nisl nisi scelerisque eu ultrices vitae auctor. Mattis nunc sed blandit libero volutpat sed cras ornare. Pulvinar neque laoreet suspendisse interdum consectetur libero.",
  images: [
    { 
      img: require("../editable-stuff/JPHHacks.jpg"), 
      label: "First slide label", 
      paragraph: "Nulla vitae elit libero, a pharetra augue mollis interdum." 
    },
    { 
      img: require("../editable-stuff/JPHHacks.jpg"), 
      label: "Second slide label", 
      paragraph: "Nulla vitae elit libero, a pharetra augue mollis interdum." 
    },
  ],
  imageSize: {
    width:"615",
    height:"450"
  }
};

// SKILLS SECTION
const skills = {
  show: true,
  heading: "Skills",
  hardSkills: [
    { name: "Cloud Security: AWS", value: 90 },
    { name: "Incident Response & Threat Detection: Splunk, Cortex XDR", value: 65 },
    { name: "Vulnerability Assessment & Management: Nessus, OpenVAS", value: 90 },
    { name: "Scripting & Automation: Python, JavaScript", value: 80 },
    { name: "Penetration Testing & Ethical Hacking: Metasploit, Nmap", value: 90 },
    { name: "Network Traffic Analysis: Wireshark", value: 80 },
    { name: "Endpoint Security: Windows Defender, Intune", value: 75 },
    { name: "Security Compliance & Risk Management: PCIDSS", value: 55},
  ],
  softSkills: [
    { name: "Attention to Detail ", value: 80 },
    { name: "Communication", value: 75 },
    { name: "Collaboration", value: 90 },
    { name: "Adaptability", value: 85 },
    { name: "Problem Solving", value: 75 },
    { name: "Time Management", value: 90 },
    { name: "Critical Thinking", value: 80 },
    { name: "Ethical Judgement", value: 90 },
  ],
};

// GET IN TOUCH SECTION
const getInTouch = {
  show: true,
  heading: "Get In Touch",
  message:
    "I'm currently looking for full-time Entry Level Cybersecurity opportunities! If you know of any positions available, if you have any questions, or if you just want to say hi, please feel free to email me at",
  email: "jpheymann@protonmail.com",
};

const experiences = {
  show: false,
  heading: "Experiences",
  data: [
    {
      role: 'Software Engineer',// Here Add Company Name
      companylogo: require('../assets/img/dell.png'),
      date: 'June 2018 – Present',
    },
    {
      role: 'Front-End Developer',
      companylogo: require('../assets/img/boeing.png'),
      date: 'May 2017 – May 2018',
    },
  ]
}

// Blog SECTION
// const blog = {
//   show: false,
// };

export { navBar, mainBody, about, repos, skills, leadership, getInTouch, experiences };

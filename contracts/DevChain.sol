// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract ProjectPartnership {

    struct Project {
        address owner;
        string title;
        bytes32 contentHash; // Hashed content of the project idea
        mapping(address => bool) interestedDevelopers;
    }

    Project[] public projects;

    event ProjectPosted(address indexed owner, uint256 projectId);
    event DeveloperInterested(address indexed developer, uint256 projectId);

    // Post a project with its title and a hashed version of its content
    function postProject(string memory _title, bytes32 _contentHash) public {
        uint256 newProjectId = projects.length;
        projects.push();
        Project storage newProject = projects[newProjectId];

        newProject.owner = msg.sender;
        newProject.title = _title;
        newProject.contentHash = _contentHash;

        emit ProjectPosted(msg.sender, newProjectId);
    }

    // Developers show interest in a project, thereby signing the binding agreement
    function expressInterest(uint256 projectId) public {
        require(projectId < projects.length, "Invalid project ID");
        
        Project storage project = projects[projectId];

        require(msg.sender != project.owner, "Owner cannot express interest in their own project");

        // Marking that the developer is interested and acknowledges the agreement
        project.interestedDevelopers[msg.sender] = true;
        emit DeveloperInterested(msg.sender, projectId);
    }

    // Check if the provided content matches the stored hash for a project (helpful in disputes)
    function verifyProjectContent(uint256 projectId, string memory content) public view returns (bool) {
        require(projectId < projects.length, "Invalid project ID");

        bytes32 hashToVerify = keccak256(abi.encodePacked(content));
        return projects[projectId].contentHash == hashToVerify;
    }

    // Total number of projects
    function totalProjects() public view returns(uint256) {
        return projects.length;
    }
}
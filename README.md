# RecruitBuddy: AI-Powered Hiring Automation Suite

RecruitBuddy is a fully automated, intelligent recruitment assistant that transforms how organizations hire talent — from job description generation to interview scheduling, evaluation, and onboarding.  
Designed for **Slack-first communication**, **minimal recruiter effort**, and **maximum candidate experience**.

---

## Overview

RecruitBuddy streamlines and enhances the entire recruitment pipeline using modular AI agents and collaborative Slack-based workflows.  
It is built to:

-  Reduce **time-to-hire**
-  Lower **cost-per-hire**
-  Improve **candidate engagement**
-  Eliminate **recruiter burnout**
-  Minimize **manual intervention**

---

## Tech Stack

RecruitBuddy is built using a powerful combination of Salesforce-native technologies, Apex Functions, AI Agents, and Lightning Web Components — designed for seamless automation and scalability.

---

### AI Agents

| Agent Name                            | Description                                                                 |
|--------------------------------------|-----------------------------------------------------------------------------|
| **Job Description Generator**        | Creates structured, detailed job listings based on short recruiter prompts |
| **Agentforce Resume Round 0 Agent**  | Sends questions to candidates via Slack and evaluates initial responses     |
| **Resume Screening Assistant**       | Parses resumes and evaluates candidate fit based on job descriptions       |
| **Summary-to-Interview Agent**       | Generates concise candidate summaries and scores for interviewers          |

---

### Apex Functions

These serverless functions power backend logic and automation across the recruitment pipeline.

| Function Name                     | Description                                                               |
|----------------------------------|----------------------------------------------------------------------------|
| `SendQuestions`                  | Sends personalized Slack questions to candidates                           |
| `SubmitReviewAndNotifySlack`     | Submits evaluation results and notifies Slack channel                      |
| `GetApplicationAndJob`           | Fetches application and job metadata for processing                        |
| `JobFetcher`                     | Retrieves job postings and associated details                              |
| `ResumeUploadHandler`            | Handles and processes uploaded resumes                                     |
| `PostJobDescription`             | Publishes AI-generated job descriptions to the careers site                |
| `GetParsedPDF`                   | Extracts structured content from uploaded resume PDFs                      |
| `ParseResumePDF`                 | Performs AI-based parsing of resume documents                              |

---

### Apex Classes

Encapsulated logic in Apex to support functionality across the app.

| Class Name               | Description                                      |
|--------------------------|--------------------------------------------------|
| `GetApplicationAndJob`   | Fetches combined application and job details     |
| `GetParsedPDF`           | Parses resume PDF and prepares structured output |
| `JobFetcher`             | Retrieves and filters job postings               |

---

### Flows

Salesforce Flows orchestrate low-code automations for key stages in the recruitment journey.

| Flow Name                | Purpose                                                      |
|--------------------------|--------------------------------------------------------------|
| `Job Description Saved`  | Triggers AI JD creation and Slack posting upon form submit   |
| `Add Resume`             | Automates resume parsing and creates application record      |
| `Fetch JD`               | Pulls job descriptions for display or further processing     |

---

### Backend

| Stack Component      | Description                                                  |
|----------------------|--------------------------------------------------------------|
| **Apex Functions**   | Serverless execution of core business logic and integrations |

---

### Frontend

| Component                  | Description                                                            |
|----------------------------|------------------------------------------------------------------------|
| **Lightning Web Components (LWC)** | Modern UI components used for recruiter and admin portals      |
| **Site Builder (HTML/CSS)**        | Customizes the public-facing career site and branding layers   |

---

### Database

| Tool           | Role                                                                             |
|----------------|----------------------------------------------------------------------------------|
| **Salesforce Data Cloud** | Stores candidate profiles, applications, job data, and AI evaluations |

---

### 🔗 Integrations

| Platform         | Purpose                                                               |
|------------------|-----------------------------------------------------------------------|
| **Slack API**    | Candidate and recruiter communication                                 |
| **Google Calendar API** | Interview scheduling and reminders                             |
| **OpenAI API / LLMs** | Natural language generation and understanding for JD and answers |

---

This modular tech stack ensures that **RecruitBuddy** is scalable, efficient, and highly extensible for real-world enterprise-grade recruitment operations.

---


##  Key Features

### 1.  Prompt-Based Job Description Generation
- **Input:** A short prompt (e.g., _“Need a Python developer”_)
- **Output:** Structured, detailed, and role-specific job description
- **Auto-Publishing:** JD is automatically published to the company’s career page

---

### 2.  Personalized Candidate Interaction
- **Resume-Based Question Generation**
  - 5 technical questions
  - 1 behavioral question
  - 1 company-specific question
- **Slack Engagement:** All questions sent to candidates via Slack for a conversational experience

---

### 3.  Real-Time Application Evaluation
- **AI-Driven Evaluation:** Responses analyzed in the context of resume and role
- **Instant Feedback:** Rejected candidates are notified instantly with respectful reasons
- **Centralized DB:** All evaluations are logged in platforms like DataCloud for easy access

---

### 4.  Smart Candidate Filtering & Interview Assignment
- **Automated Screening:** Filters out irrelevant or unqualified applicants
- **Interviewer Matching:** Assigns the most relevant interviewer based on:
  - Skill alignment
  - Availability
- **Context-Rich Handover:** Interviewers receive:
  - Resume summary
  - AI evaluation
  - Question responses

---

### 5.  AI-Coordinated Interview Scheduling
- **Slack-Based Scheduler Agent:** Coordinates availability between candidate and interviewer
- **Calendar Integration:** Syncs with tools like Google Calendar
- **Reminders:** Automatically schedules and sends reminders

---

### 6.  AI-Attended Interview Reviews
- **Passive Attendance:** AI listens to interviews in real-time
- **Pre-Filled Review Form:** Drafted automatically based on conversation
- **Interviewer Effort:** Only edits/approves the AI-generated feedback

---

### 7.  Automated HR Onboarding
- **Slack Workflow:** Step-by-step onboarding via Slack
- **Document Verification:** Handled by background check agents
- **Auto-Fill Forms:** Compliance and HR forms pre-filled by AI
- **Account Provisioning:** Integrates with IT systems to create user accounts

---

## Financials and Cost Saving


### Job Description & Posting

| Task                     | Traditional                        | Your AI                      | System Savings |
|--------------------------|-------------------------------------|-------------------------------|----------------|
| Time to write JD         | 3 hours @ $50/hr = $150             | $0 (AI-generated)             | ✅ $150        |
| Job board/SEO updates    | $100                                | $0 (automated posting)        | ✅ $100        |

### Resume Screening & Candidate Questions

| Task                          | Traditional                          | Your AI                  | System Savings |
|-------------------------------|---------------------------------------|---------------------------|----------------|
| Manual resume review          | 30 mins @ $50/hr = $25                | $0 (AI-screened)          | ✅ $25         |
| Custom question creation      | 45 mins @ $50/hr = $37.5              | $0 (auto-generated)       | ✅ $37.5       |
| Slack messaging (vs. email)   | 20 mins @ $50/hr = $16.66             | $0                         | ✅ $16.66      |

### Interview Scheduling

| Task                         | Traditional                      | Your AI                        | System Savings |
|------------------------------|-----------------------------------|--------------------------------|----------------|
| Manual back-and-forth emails | 30 mins @ $50/hr = $25            | $0 (AI schedules on Slack)     | ✅ $25         |

### Interview Review & Evaluation

| Task                         | Traditional                      | Your AI                                  | System Savings     |
|------------------------------|-----------------------------------|-------------------------------------------|--------------------|
| Manual interview feedback    | 30 mins @ $50/hr = $25            | 5 mins to approve AI draft = ~$4.17       | ✅ ~$20.83         |

### Delayed Rejection (Hurts Reputation)

| Task                                      | Traditional                  | Your AI                          | System Savings                 |
|-------------------------------------------|-------------------------------|----------------------------------|--------------------------------|
| Ghosting or delayed feedback (hurts brand)| High reputational cost       | Instant, respectful AI feedback | ✅ Intangible but high value   |

### Candidate Dropout & Time-to-Hire Reduction

Faster process = fewer dropouts + faster hiring.
Assume your AI system cuts time-to-hire by 40%, reducing lost candidates (opportunity cost).

Industry estimate: $100–$500 saved per hire.  
Conservatively, let’s use **$150 saved per hire**.


### Total Saving Per Year

$564.9 * 1250 = $7,061,250  
(assuming 1250 candidates are hired/year)

### Total Saving Per Year

$564.9 * 1250 = $7,061,250  
(assuming 1250 candidates are hired/year)

### Total Estimated Saving Per Hire

| Category                              | Savings    |
|---------------------------------------|------------|
| JD Creation & Posting                 | $250       |
| Screening & Engagement                | $79.16     |
| Interview Scheduling                  | $25        |
| Feedback Automation                   | $20.83     |
| Candidate Experience                  | $40        |
| Faster Hiring (Opportunity Cost)      | $150       |
| **Total per Hire**                    | **~ $564.9** |

### Total Time Saved Per Year

55.83 hrs * 1250 = 69,791.67 hrs  
= 2,908 business days


---

##  Project Objectives

| Module                     | Objective                                                                 |
|----------------------------|---------------------------------------------------------------------------|
| **Meeting Scheduler**      | AI agent schedules meetings based on user’s task work pattern             |
| **Decision Automation**    | Converts meeting outcomes to form entries and event setup                 |
| **Unified Communication**  | All recruiter-candidate interaction via Slack                            |
| **Onboarding Automation**  | Background checks, document verification, and provisioning via agents     |
| **JD Creation**            | Prompt-based generation of job listings using AI                         |
| **Round 0 Screening**      | Resume-based custom questions and AI evaluation                          |
| **Summary Reports**        | Interviewers receive AI-generated candidate summaries before interviews  |

---

##  Future Enhancements

### 1.  Smart Interview Assistant
- Passive AI listener during interviews
- Can answer interviewer's or candidate's queries about the job or each other in real-time
- Accesses documents, resume highlights, interview context, and recruiter notes on-the-fly

### 2.  Full-Scale Onboarding Suite
- Complete onboarding support including:
  - Document submission
  - Background check
  - IT provisioning
  - Office tour and team intros (virtual or hybrid)

### 3.  Analytics & Optimization
- Dashboard for recruitment KPIs
- Trends in candidate funnel, interviewer efficiency, diversity metrics, and cost-per-hire analysis

### 4.  Continuous Learning Engine
- AI improves its screening, questioning, and evaluation over time through recruiter feedback loops

### 5.  Privacy & Compliance Layer
- GDPR-compliant data handling
- Automated anonymization for bias-free evaluations

---


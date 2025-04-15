# Cloud Resume Challenge – Frontend

This is the frontend portion of my Cloud Resume Challenge project, built to showcase my cloud and DevOps skills. It’s a simple resume site hosted on AWS using modern services and infrastructure as code.

## 🌐 Live Site

👉 [williamofleming.com](https://www.williamofleming.com)

## 🛠️ Tech Stack

- HTML / CSS / JavaScript
- AWS S3 (static site hosting)
- AWS CloudFront (global CDN)
- AWS Certificate Manager (HTTPS via custom domain)
- Route 53 (domain management)
- GitHub Actions (CI/CD pipeline)

## 🚀 CI/CD Workflow

Every push to the `main` branch triggers a GitHub Actions workflow that:

1. Builds the frontend
2. Syncs static files to an S3 bucket
3. Invalidate CloudFront cache to reflect changes immediately

## 🧱 Infrastructure

Infrastructure for the frontend is defined and managed using [Terraform](https://github.com/flmngwllm/cloud-resume-back).

## 📸 Screenshot

![Site Screenshot](https://www.williamofleming.com/screenshot.png) <!-- Optional, if you want to add one -->

## 📁 Related Repositories

- [Backend Repo](https://github.com/flmngwllm/cloud-resume-back) – Handles visitor counter logic and infrastructure

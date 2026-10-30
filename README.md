# Automated DLP Incident Response with Microsoft Purview & PowerShell

## Executive Summary
This repository contains an end-to-end automated framework for Data Loss Protection (DLP) incident response and triage. By integrating Microsoft Purview DLP Policies with custom PowerShell automation scripts, this solution captures, processes, and logs sensitive data exposure events in real time.

The project demonstrates practical implementation of Information Protection principles, tenant-level governance, and structured incident logging for SOC/SecOps teams.

## Architecture & Component Overview
* Tenant Environment: purviewsecops.onmicrosoft.com
* DLP Policy: Project Alpha DLP Policy
* Sensitive Information Type (SIT): Regex pattern matching ALPHA-[0-9]{4}-[A-Z]{2}
* Enforcement: Blocks external sharing of sensitive project documentation in OneDrive and SharePoint.
* Triage Engine: PowerShell script for automated event parsing, metadata enrichment, and JSON/CSV log generation.
* Version Control: Git workflow automation for report and script synchronization.

## Repository Structure
automated-dlp-incident-response-purview/
+-- DLP_Incident_Reports/     # Generated incident logs (JSON/CSV)
+-- scripts/                  # Core PowerShell automation scripts
¦   +-- Invoke-DLPIncidentTriage.ps1
¦   +-- Invoke-GitAutomation.ps1
+-- templates/                # Sample reporting schemas for downstream SIEM integration

## Execution & Usage

### 1. Run DLP Incident Triage Script
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process -Force
.\scripts\Invoke-DLPIncidentTriage.ps1 -TenantDomain "purviewsecops.onmicrosoft.com"

### 2. Synchronize Artifacts to GitHub
.\scripts\Invoke-GitAutomation.ps1 -Message "Updated DLP incident response logs"

## Sample Incident Output (JSON)
{
  "incidentId": "DLP-INT-4821",
  "timestamp": "2026-10-22 23:10:00",
  "tenant": "purviewsecops.onmicrosoft.com",
  "user": "rhuayamave@purviewsecops.onmicrosoft.com",
  "fileName": "confidentialxy.docx",
  "recipient": "mcardenaschalco@gmail.com",
  "policyName": "Project Alpha DLP Policy",
  "ruleName": "Detect and Block Project Alpha Data",
  "action": "Blocked External Sharing & Remediation Logged",
  "triageStatus": "Completed"
}

## SC-401 & Security Compliance Alignment
* Data Loss Prevention: Enforcement of scoped access controls and perimeter protection.
* Incident Handling: Structured triage, artifact generation, and evidence storage.
* SecOps Integration: Export-ready JSON/CSV formats compatible with Microsoft Sentinel and custom SIEM pipelines.

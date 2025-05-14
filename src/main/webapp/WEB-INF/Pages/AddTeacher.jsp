<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SuyoGuruu - Add Teacher</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/AddTeacher.css">
    <style>
        .dashboard-container {
            display: flex;
            gap: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .form-container {
            flex: 1;
        }
        
        .preview-container {
            flex: 1;
            background-color: #f9f9f9;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .preview-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .preview-table th, .preview-table td {
            padding: 8px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }
        
        .preview-table th {
            background-color: #f2f2f2;
        }
        
        .no-data {
            text-align: center;
            color: #888;
            padding: 20px;
        }
        
        .example-buttons {
            margin-bottom: 20px;
        }
        
        .example-btn {
            padding: 8px 12px;
            margin-right: 10px;
            background-color: #eee;
            border: 1px solid #ddd;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        .example-btn:hover {
            background-color: #ddd;
        }
    </style>
</head>
<body>
    <header>
        <div class="logo">
            <img src="<%= request.getContextPath() %>/Resources/Images/Logo.jpg" alt="SuyoGuruuLogo">
            <h1>SuyoGuruu Teacher Management System</h1>
        </div>
        <nav>
            <a href="<%= request.getContextPath() %>/dashboard.jsp">Information</a>
            <a href="${pageContext.request.contextPath}/timetable.jsp">Schedule Management</a>
            <a href="${pageContext.request.contextPath}/home">Home</a>
        </nav>
    </header>

    <main>
        <div class="page-header">
            <h2>Add Teacher</h2>
            <p>Enter the details to add a new teacher to the system</p>
        </div>

        <div class="dashboard-container">
            <div class="form-container">
                <div class="example-buttons">
                    <button type="button" class="example-btn" onclick="loadExample('swoopna')">Example: Swoopna Suman</button>
                    <button type="button" class="example-btn" onclick="loadExample('kumar')">Example: Kumar Sagar</button>
                </div>
                
                <form action="<%= request.getContextPath() %>/processAddTeacher.jsp" method="post" id="teacherForm">
                    <div class="form-section">
                        <h3>Personal Information</h3>
                        <div class="form-group">
                            <label for="teacherId">Teacher ID<span class="required">*</span></label>
                            <input type="text" id="teacherId" name="teacherId" required oninput="updatePreview()">
                        </div>
                        
                        <div class="form-group">
                            <label for="teacherName">Teacher Name<span class="required">*</span></label>
                            <input type="text" id="teacherName" name="teacherName" required oninput="updatePreview()">
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="email">Email<span class="required">*</span></label>
                                <input type="email" id="email" name="email" required oninput="updatePreview()">
                            </div>
                            <div class="form-group">
                                <label for="phone">Phone Number</label>
                                <input type="tel" id="phone" name="phone" oninput="updatePreview()">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="address">Address<span class="required">*</span></label>
                            <input type="text" id="address" name="address" required oninput="updatePreview()">
                        </div>
                        
                        <div class="form-group">
                            <label for="department">Department<span class="required">*</span></label>
                            <select id="department" name="departmentID" required onchange="updatePreview()">
                                <option value="">-- Select Department --</option>
                                <option value="1">Mathematics</option>
                                <option value="2">Science</option>
                                <option value="3">Languages</option>
                                <option value="4">Social Studies</option>
                                <option value="5">Computer Science</option>
                                <option value="6">Arts</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-actions">
                        <button type="button" class="btn-primary" onclick="saveTeacher()">Save Teacher</button>
                        <button type="button" class="btn-outline" onclick="location.href='<%= request.getContextPath() %>/teachers.jsp'">Cancel</button>
                    </div>
                </form>
            </div>
            
            <div class="preview-container">
                <h3>Preview Information</h3>
                <table class="preview-table">
                    <thead>
                        <tr>
                            <th>Field</th>
                            <th>Value</th>
                        </tr>
                    </thead>
                    <tbody id="previewTableBody">
                        <tr>
                            <td colspan="2" class="no-data">Enter information to see preview</td>
                        </tr>
                    </tbody>
                </table>
                
                <div id="savedMessage" style="display: none; margin-top: 20px; padding: 10px; background-color: #dff0d8; color: #3c763d; border-radius: 4px;">
                    Teacher information has been saved successfully!
                </div>
            </div>
        </div>
    </main>
    
    <footer>
        <p>&copy; 2025 SuyoGuruu Teacher Management System. All rights reserved.</p>
    </footer>

    <script>
        function updatePreview() {
            const previewTableBody = document.getElementById('previewTableBody');
            previewTableBody.innerHTML = '';
            
            // Get form values
            const teacherId = document.getElementById('teacherId').value;
            const teacherName = document.getElementById('teacherName').value;
            const email = document.getElementById('email').value;
            const phone = document.getElementById('phone').value;
            const address = document.getElementById('address').value;
            
            // Get department value
            const departmentSelect = document.getElementById('department');
            const departmentValue = departmentSelect.value;
            const departmentText = departmentValue ? departmentSelect.options[departmentSelect.selectedIndex].text : '';
            
            // Add rows to preview table
            if (teacherId) {
                addPreviewRow('Teacher ID', teacherId);
            }
            
            if (teacherName) {
                addPreviewRow('Teacher Name', teacherName);
            }
            
            if (email) {
                addPreviewRow('Email', email);
            }
            
            if (phone) {
                addPreviewRow('Phone', phone);
            }
            
            if (address) {
                addPreviewRow('Address', address);
            }
            
            if (departmentText) {
                addPreviewRow('Department', departmentText);
            }
            
            // Show "no data" message if no fields are filled
            if (previewTableBody.children.length === 0) {
                const noDataRow = document.createElement('tr');
                noDataRow.innerHTML = '<td colspan="2" class="no-data">Enter information to see preview</td>';
                previewTableBody.appendChild(noDataRow);
            }
            
            // Hide saved message when form is updated
            document.getElementById('savedMessage').style.display = 'none';
        }
        
        function addPreviewRow(field, value) {
            const previewTableBody = document.getElementById('previewTableBody');
            const newRow = document.createElement('tr');
            newRow.innerHTML = `
                <td><strong>${field}</strong></td>
                <td>${value}</td>
            `;
            previewTableBody.appendChild(newRow);
        }
        
        function loadExample(example) {
            // Clear form
            document.getElementById('teacherForm').reset();
            
            if (example === 'swoopna') {
                // Load Swoopna Suman example
                document.getElementById('teacherId').value = 'T001';
                document.getElementById('teacherName').value = 'Swoopna Suman';
                document.getElementById('email').value = 'swoopna.suman@suyoguruu.edu';
                document.getElementById('phone').value = '9801234567';
                document.getElementById('address').value = 'Kathmandu, Nepal';
                document.getElementById('department').value = '3'; // Languages department
            } else if (example === 'kumar') {
                // Load Kumar Sagar example
                document.getElementById('teacherId').value = 'T002';
                document.getElementById('teacherName').value = 'Kumar Sagar';
                document.getElementById('email').value = 'kumar.sagar@suyoguruu.edu';
                document.getElementById('phone').value = '9807654321';
                document.getElementById('address').value = 'Lalitpur, Nepal';
                document.getElementById('department').value = '1'; // Mathematics department
            }
            
            // Update preview
            updatePreview();
        }
        
        function saveTeacher() {
            // Validate form
            const form = document.getElementById('teacherForm');
            if (!form.checkValidity()) {
                // If form is invalid, trigger HTML5 validation
                form.reportValidity();
                return;
            }
            document.getElementById('savedMessage').style.display = 'block';
        }
    </script>
</body>
</html>
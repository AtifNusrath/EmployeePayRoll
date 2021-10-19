package com.bridgelabz;

import org.junit.jupiter.api.Test;
import java.util.Arrays;

import static com.bridgelabz.EmployeePayrollService.IOService.FILE_IO;

public class EmployeePayrollServiceTest {
    @Test

    public void given3EmployeesWhenWrittenToFileShouldMatchEmployeeEntries() {
        EmployeePayrollData[] arrayofEmp = {
                new EmployeePayrollData(1,"Jeff", 1000000.0),
                new EmployeePayrollData(2,"Jeff", 2000000.0),
                new EmployeePayrollData(3,"Jeff", 3000000.0),
        };
        EmployeePayrollService employeePayrollService;

        employeePayrollService = new EmployeePayrollService(Arrays.asList(arrayofEmp));
        employeePayrollService.writeEmployeePayrollData(FILE_IO);
        employeePayrollService.printData(FILE_IO);
    }
}

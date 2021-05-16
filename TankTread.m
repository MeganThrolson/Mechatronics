classdef TankTread < matlab.System
    properties
       output 
        A_motor
        B_motor
       
        
        A_tank
        B_tank
        
    end
    methods
        function addMotor(obj,R,L, N, J_motor,mod, D, K_shaft, J_gear, J_roller)
            obj.A_motor= [-R/L -N/J_motor 0 0;
                          mod/L -D/J_motor 0 0;
                          1/J_motor 0 0 (-1/(J_gear + J_roller))/188;
                          0 0 188*K_shaft 0];
            obj.B_motor = [1;0;0;0];               
        end
        function TankBuilder(obj,M_Rocker,K_arm,R_arm,M_tank,J_arm,J_tank,K_spring, K_tread)
            obj.A_tank = [0 1/M_Rocker 0 0 0 0;
                      K_tread 0 0 K_arm/R_arm 0 0;
                     0 0 0 K_arm/R_arm 0 0;
                    0 0 0 K_arm/R_arm 0 0;
                      0 0 0 0 0 ((J_arm +J_tank)/6);
                      0 0 0 K_arm -K_spring 0];
                  obj.B_tank = [1;K_tread;0;0;0;0];
        end
      
        function  Driving(obj,z_values)
            obj.output = zeros((47/.1),6);
            for i = 1:47.0/.1
             if i == 1
                 x = [0;0;0;0;0;0];
             else
                 x = obj.output(i-1,1:6)';
             end
             obj.output(i,1:6) = obj.A_tank*x + obj.B_tank*z_values(i,1);
            end
        end
    end
end
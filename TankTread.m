classdef TankTread
    properties
       
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
            obj.B_Motor = [1;0;0;0];               
        end
        function TankBuilder(obj,M_Rocker,K_arm,R_arm,M_tank,J_arm,J_tank,K_spring, K_tread)
            obj.A_tank = [0 1/M_Rocker 0 0 0 0;
                      0 0 0 K_arm/R_arm 0 0;
                      0 0 0 -K_arm/R_arm 0 0;
                      0 (1/M_Rocker)/R_arm (1/(M_tank/6))/R_arm 0 0 1/(J_arm + (J_tank/6));
                      0 0 0 0 0 -1/(J_arm +(J_tank/6));
                      0 0 0 0 K_arm -K_spring 0];
                  obj.B_tank = [1;K_tread;0;0;0;0];
        end
      
        function  Driving(obj, road)
            obj.output = zeros(road.numSteps,1);
            for i = 1:road.numSteps
             if i == 1
                 x = [0;0;0;0;0;0];
             else
                 x = obj.output(i-1);
             end
             obj.output(i) = obj.A_tank*x + obj.B_tank*road.Input(i);
            end
        end
    end
end
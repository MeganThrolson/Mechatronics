classdef TankTread
    properties
        k_torsion
        k_spring
        
        A
        X
        B
        
    end
    methods
        function TankBuilder(obj,k_torsion, k_spring)
            obj.k_torsion = k_torsion;
            obj.k_spring = k_spring;
        end
        function solveA(obj)
        end
        function solveX(obj)
        end
        function SolveB(obj)
        end
        function output = Driving(obj, road)
            output = obj.A*obj.X + obj.B*road.Input;
        end
    end
end
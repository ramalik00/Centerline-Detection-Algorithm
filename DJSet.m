classdef DJSet < handle
    properties
        N; root;size;
    end

    methods
        function obj=DJSet(n)
            obj.N = n;
            obj.root = 1:n;
            obj.size = ones(1,n);
        end

        function root = find(obj, u)
            while obj.root(u) ~= u
                obj.root(u) = obj.root(obj.root(u));
                u = obj.root(u);
            end
            root = u;
        end

        function union(obj, u, v)
            root_u = obj.find(u);
            root_v = obj.find(v);
            if root_u == root_v
                return;
            end
            if obj.size(root_u) < obj.size(root_v)
                obj.root(root_u) = root_v;
                obj.size(root_v) = obj.size(root_v) + obj.size(root_u);
            else
                obj.root(root_v) = root_u;
                obj.size(root_u) = obj.size(root_u) + obj.size(root_v);
            end
        end

        function res = is_connected(obj, u, v)
            root_u = obj.find(u);
            root_v = obj.find(v);
            res = root_u == root_v;
        end
    end
end